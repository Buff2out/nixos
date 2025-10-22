{ config, pkgs, ... }:

{
  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    
    # PRIME конфигурация (добавлено)
    prime = {
      # Reverse PRIME: NVIDIA рендерит, Intel отображает
      reverseSync.enable = true;
      
      # Bus ID твоих GPU (из lspci)
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      nvidia-vaapi-driver
      vaapiVdpau
      libvdpau-va-gl
    ];
  };

  # Переменные окружения для Wayland (добавлено)
  environment.sessionVariables = {
    WLR_DRM_DEVICES = "/dev/dri/card1";  # NVIDIA
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    LIBVA_DRIVER_NAME = "nvidia";
    GBM_BACKEND = "nvidia-drm";
  };

  environment.systemPackages = with pkgs; [
    cudatoolkit
    nv-codec-headers
    nvtopPackages.nvidia  # мониторинг GPU (опционально)
  ];
}
