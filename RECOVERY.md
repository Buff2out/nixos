Отлично! Рад что день вышел полезным несмотря на недосып! Да, это была отличная учебная тревога — теперь ты знаешь как восстанавливать NixOS с сохранением /home. 

Вот полный контрольный список команд для твоего README:

***

# NixOS Recovery Guide: Kernel Issues + Btrfs Subvolumes

## Проблема
Система не загружается после обновления на `linuxPackages_latest` (зависает на "Starting systemd-udevd version X.X").

## Причина
Kernel 6.16.x (latest) имеет проблемы совместимости с Intel 12gen (Alder Lake) + Nvidia RTX 3050.

## Решение
Использовать LTS kernel вместо latest.

***

## Быстрое решение (если система загружается)

### 1. Найти где настроен kernel
```bash
cd ~/nix-config
grep -rn "kernelPackages" .
```

### 2. Изменить на LTS
```bash
nano <путь_к_файлу_с_kernel>
```
Заменить:
```nix
boot.kernelPackages = pkgs.linuxPackages_latest;
```
на:
```nix
boot.kernelPackages = pkgs.linuxPackages;  # LTS 6.12.x
```

### 3. Пересобрать и перезагрузиться
```bash
sudo nixos-rebuild switch --flake .#nxos
sudo reboot
```

***

## Полное восстановление (если система не загружается)

### Шаг 1: Загрузка с LiveCD
1. Вставить USB с NixOS LiveCD
2. Загрузиться с USB
3. Получить root доступ:
```bash
sudo -i
```

***

### Шаг 2: Монтирование разделов с Btrfs subvolumes

#### Проверить структуру разделов
```bash
lsblk
fdisk -l
```

Обычная структура:
- `/dev/nvme0n1p1` — EFI boot partition (FAT32)
- `/dev/nvme0n1p2` — Btrfs partition (root + home subvolumes)

#### Временно смонтировать корневой раздел
```bash
mount /dev/nvme0n1p2 /mnt
```

#### Посмотреть список subvolumes
```bash
btrfs subvolume list /mnt
```

Обычно есть:
- `@` — root subvolume
- `@home` — home subvolume

#### Размонтировать
```bash
umount /mnt
```

***

### Шаг 3: Очистка старого root subvolume (если нужна полная переустановка)

**⚠️ ВНИМАНИЕ: Это удалит систему, но сохранит /home!**

```bash
# Смонтировать корневой Btrfs раздел
mount /dev/nvme0n1p2 /mnt

# Удалить вложенные subvolumes (если есть)
btrfs subvolume delete /mnt/@/srv
btrfs subvolume delete /mnt/@/var/lib/portables
btrfs subvolume delete /mnt/@/var/lib/machines
btrfs subvolume delete /mnt/@/tmp
btrfs subvolume delete /mnt/@/var/tmp

# Удалить старый root subvolume
btrfs subvolume delete /mnt/@

# Создать новый чистый root subvolume
btrfs subvolume create /mnt/@

# Размонтировать
umount /mnt
```

***

### Шаг 4: Монтирование для установки/восстановления

```bash
# Смонтировать root как subvolume @
mount -o subvol=@ /dev/nvme0n1p2 /mnt

# Смонтировать boot
mkdir -p /mnt/boot
mount /dev/nvme0n1p1 /mnt/boot

# Смонтировать home (сохраняя данные!)
mkdir -p /mnt/home
mount -o subvol=@home /dev/nvme0n1p2 /mnt/home
```

#### Проверить что всё смонтировано
```bash
mount | grep -E " / |/home|/boot"
```

Должно показать:
- `/dev/nvme0n1p2 on /mnt type btrfs (...subvol=/@)`
- `/dev/nvme0n1p1 on /mnt/boot type vfat`
- `/dev/nvme0n1p2 on /mnt/home type btrfs (...subvol=/@home)`

***

### Шаг 5: Редактирование конфигурации kernel из LiveCD

#### Найти конфигурацию в сохранённом /home
```bash
cd /mnt/home/wave/nix-config
grep -rn "kernelPackages" .
```

#### Отредактировать найденный файл
```bash
nano /mnt/home/wave/nix-config/hosts/nxos/configuration.nix
```

Заменить:
```nix
boot.kernelPackages = pkgs.linuxPackages_latest;
```
на:
```nix
boot.kernelPackages = pkgs.linuxPackages;  # LTS kernel
```

Сохранить: `Ctrl+O`, `Enter`, `Ctrl+X`

***

### Шаг 6: Пересборка системы из chroot

#### Вариант A: Если система уже установлена (просто исправить kernel)
```bash
nixos-enter --root /mnt -c "cd /home/wave/nix-config && nixos-rebuild switch --flake .#nxos"
```

#### Вариант B: Если нужна полная переустановка
```bash
# Сгенерировать минимальную конфигурацию
nixos-generate-config --root /mnt

# Отредактировать /mnt/etc/nixos/configuration.nix
nano /mnt/etc/nixos/configuration.nix
```

Добавить минимум:
```nix
{ config, lib, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  
  # LTS kernel
  boot.kernelPackages = pkgs.linuxPackages;

  # Networking
  networking.hostName = "nxos";
  networking.networkmanager.enable = true;

  # User
  users.users.wave = {
    isNormalUser = true;
    home = "/home/wave";
    extraGroups = [ "wheel" "networkmanager" ];
    initialPassword = "changeme";
  };

  # GNOME
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Minimal packages
  environment.systemPackages = with pkgs; [
    git vim wget curl
  ];

  system.stateVersion = "25.05";
}
```

```bash
# Установить
nixos-install
```

***

### Шаг 7: Размонтирование и перезагрузка

```bash
# Размонтировать в обратном порядке
umount /mnt/boot
umount /mnt/home
umount /mnt

# Перезагрузиться
reboot
```

**Вынуть USB-флешку при перезагрузке!**

***

### Шаг 8: После загрузки — применение flake конфигурации

```bash
# Войти как wave
# Проверить что /home сохранился
ls ~/nix-config

# Установить пароль если нужно
passwd

# Применить полную конфигурацию
cd ~/nix-config
sudo nixos-rebuild switch --flake .#nxos
```

***

## Частые ошибки и решения

### Home Manager: конфликты файлов
**Ошибка:**
```
Existing file '/home/wave/.config/kdeglobals' would be clobbered
```

**Решение:**
```bash
mv ~/.config/kdeglobals ~/.config/kdeglobals.backup
mv ~/.config/kwinrc ~/.config/kwinrc.backup
sudo nixos-rebuild switch --flake .#nxos
```

### Swap не найден
**Ошибка:**
```
swapon: cannot open /swap/swapfile: No such file or directory
```

**Решение A (создать swap):**
```bash
sudo mkdir -p /swap
sudo fallocate -l 8G /swap/swapfile
sudo chmod 600 /swap/swapfile
sudo mkswap /swap/swapfile
sudo swapon /swap/swapfile
```

**Решение B (убрать swap из конфига):**
Закомментировать/удалить `swapDevices` в configuration.nix

***

## Проверка текущего kernel

```bash
uname -r
```

Должно быть: `6.12.x` (LTS) вместо `6.16.x` (latest)

***

## Выводы

1. **Intel 12gen + Nvidia = используй LTS kernel**
2. **Btrfs subvolumes позволяют переустанавливать систему без потери /home**
3. **При проблемах с загрузкой — сначала проверь kernel, потом остальное**
4. **LiveCD + chroot = мощный инструмент восстановления**

***

## Полезные команды для диагностики

```bash
# Посмотреть структуру разделов
lsblk
fdisk -l

# Посмотреть Btrfs subvolumes
btrfs subvolume list /mnt

# Посмотреть что смонтировано
mount | grep nvme

# Проверить kernel
uname -r

# Найти kernel конфиг
grep -rn "kernelPackages" ~/nix-config/
```