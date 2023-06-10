# Lenovo ThinkPad T580 hackintosh
Personal notes on configuring OpenCore for this laptop.

Status:
| component | status |
| -- | -- |
| WiFi | Working |
| Bluetooth | Working |
| Audio | Working |
| Ethernet | Working |
| GPU Acceleration | Working |
| Backlight | Working |
| USB | Working |
| Keyboard/Touchpad | Working |
| Dual Battery | Working |
| Sleep | Working |

## ACPI
- Battery: SSDT-BATC (compiled manually), custom SSDT-DBAT
- CPU: SSDT-PLUG (compiled manually)
- EC: SSDT-USBX (precompiled)
- Backlight: SSDT-PNLF (compiled manually)

## Firmware drivers
Base drivers:
- OpenRuntime.efi
- HfsPlus.efi

PS/2 keyboard+mouse support:
- Ps2KeyboardDxe.efi
- Ps2MouseDxe.efi

## Kexts
| component | kext |
| -- | -- |
| WiFi | AirportItlwm.kext |
| Audio | AppleALC.kext |
| Bluetooth | BlueToolFixup.kext<br/>IntelBTPatcher.kext<br/>IntelBluetoothFirmware.kext |
| Backlight | BrightnessKeys.kext |
| Embedded Controller | ECEnabler.kext |
| Ethernet | IntelMausi.kext |
| USB | USBMap.kext (custom) |
| PS/2 | VoodooPS2Controller.kext |
| GPU | WhateverGreen.kext |
| Other | Lilu.kext<br/>VirtualSMC.kext<br/>SMCBatteryManager.kext<br/>SMCLightSensor.kext<br/>SMCProcessor.kext<br/>SMCSuperIO.kext |

## config.plist

### ACPI/Patch

See BATC-Patch.plist

### DeviceProperties
- PciRoot(0x0)/Pci(0x2,0x0)

| Key | Type | Value |
| --- | ---- | ----- |
| AAPL,ig-platform-id | data | 0000C087 |
| device-id | data | 16590000 |

### Kernel quirks

| Key | Type | Value |
| --- | ---- | ----- |
| AppleXcpmCfgLock | boolean | True |
| DisableIoMapper | boolean | True |
| PanicNoKextDump | boolean | True |
| PowerTimeoutKernelPanic | boolean | True |
| XhciPortLimit | boolean | False |

### Misc/Security

| Key | Type | Value |
| --- | ---- | ----- |
| AllowSetDefault | boolean | True |
| BlacklistAppleUpdate | boolean | True |
| ScanPolicy | number | 0 |
| SecureBootModel | string | Default |
| Vault | string | Optional |

### NVRAM
- 7C436110-AB2A-4BBB-A880-FE41995C9F82

| Key | Type | Value |
| --- | ---- | ----- |
| boot-args | string | alcid=11 |
| prev-lang:kbd | string | pl-PL:30788 |
| bluetoothInternalControllerInfo | data | 00000000 00000000 00000000 0000 |
| bluetoothExternalDongleFailed | data | 00 |

### PlatformInfo
MBP14,1
*15,1 for sonoma

### UEFI/Quirks

| Key | Type | Value |
| --- | ---- | ----- |
| ReleaseUsbOwnership | boolean | True |
