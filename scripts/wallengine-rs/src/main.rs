use std::path::PathBuf;
use std::process::Command;
use rand::seq::IndexedRandom;
use walkdir::WalkDir;

fn main() {
    let wallpaper_dir = PathBuf::from("/home/wave/Pictures/wallpapers");
    
    // Рекурсивный обход с WalkDir
    let images: Vec<PathBuf> = WalkDir::new(&wallpaper_dir)
        .into_iter()
        .filter_map(|entry| entry.ok())
        .filter(|entry| entry.file_type().is_file())
        .filter_map(|entry| {
            let path = entry.path().to_path_buf();
            match path.extension()?.to_str()?.to_lowercase().as_str() {
                "png" | "jpg" | "jpeg" | "webp" => Some(path),
                _ => None,
            }
        })
        .collect();

    if images.is_empty() {
        eprintln!("❌ No wallpapers found in {}", wallpaper_dir.display());
        return;
    }

    let mut rng = rand::rng();
    let selected = images.choose(&mut rng).expect("Failed to choose wallpaper");

    // Сначала preload нового обоев
    let preload_output = Command::new("/run/current-system/sw/bin/hyprctl")
        .args(&["hyprpaper", "preload", &selected.display().to_string()])
        .output()
        .expect("Failed to preload wallpaper");

    if !preload_output.status.success() {
        eprintln!("❌ Failed to preload: {}", String::from_utf8_lossy(&preload_output.stderr));
        return;
    }

    // Затем установить обои на монитор (БЕЗ пробела после запятой!)
    let wallpaper_arg = format!("eDP-1,{}", selected.display());

    let output = Command::new("/run/current-system/sw/bin/hyprctl")
        .args(&["hyprpaper", "wallpaper", &wallpaper_arg])
        .output()
        .expect("Failed to execute /run/current-system/sw/bin/hyprctl");

    if output.status.success() {
        println!("✅ Wallpaper changed to: {}", selected.display());
    } else {
        eprintln!("❌ /run/current-system/sw/bin/hyprctl failed: {}", String::from_utf8_lossy(&output.stderr));
    }
}
