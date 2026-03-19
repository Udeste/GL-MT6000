# GL-MT6000 custom OpenWrt firmware builder

> ## ⚠️ Heavily Customized Build — Read Before Flashing
>
> This repository automates the process of building OpenWrt custom firmware images for **MY** Flint 2 (GL-MT6000) router, based on **MY PREFERENCES** and [pesa1234](https://github.com/pesa1234)'s work.
> Read [this topic](https://forum.openwrt.org/t/mt6000-custom-build-with-luci-and-some-optimization-kernel-6-12-x/185241) in OpenWrt's forum to learn the details about pesa1234's customizations.
>
> ---
>
> ### 🔑 U-Boot Environment Variables Required
>
> Several critical values are read directly from the **U-Boot environment** at boot time.  
> If these variables are **not set** on your device, flashing this image **will brick your router**. 🧱
>
> ---
>
> ### 📖 Before You Proceed
>
> Please read the [`README`](./README.md) carefully for:
>
> - 📋 The full list of required U-Boot environment variables
> - 🔧 Instructions on how to set them correctly
> - 🛡️ [Recovery options if something goes wrong](#recovery-options-if-something-goes-wrong)
>
> You should **not use** the firmwares released in this repository unless you have the exact same preferences and needs.
> Instead, **make a fork and adapt to your own setup**. 🚨



Compared to [pesa1234](https://github.com/pesa1234)'s custom firmware, this firmware adds:
<!-- - **WiFi UCODE scripts** (faster boot) -->
- **Wireguard VPN**
- **Custom Attended Sysupgrade** (install custom firmware from GitHub)
- **Shell history enabled**
- **DDNS for** Cloudflare
- Some packages included by default:
  - **collectd** and **luci-app-statistics** for monitoring and graphing system performance (CPU, RAM, network traffic, etc).
  - **iperf3** for network performance testing.
  - **watch**, **wget**, **htop**, **drill**

And also:
- **REMOVED:** adblock, avahi, samba, usb storage, zerotier, tailscale and probably more stuff I forgot to mention.
- Some compiler optimizations and build hardening options (cortex-a53+crc+crypto; LTO, MOLD, and more).
<!-- - Some debug and kernel stuff removed. -->
- [`upgrade_custom_openwrt`](files/usr/bin/upgrade_custom_openwrt) script

Check the content of [`mt6000.config`](mt6000.config) for details.

# 🔑 U-Boot Environment Variables

Some scripts in the [files/etc/uci-defaults](files/etc/uci-defaults) contains secrets (e.g. API keys, passwords, etc) read from U-Boot environment variables, such as `wifi_ssid`, `wifi_key`, etc.
This portion of memory survives across firmware upgrades, so you can set those variables once and they will be used by the scripts even after upgrading the firmware.
If those are not set, the scripts will fallback to default values.

To set those variables, you need to access the router via SSH and run the `fw_setenv` command.

Like i.e.:

```shell
root@GL-MT6000:~# fw_setenv wifi_ssid "your_wifi_ssid"`
```
### Recovery options if something goes wrong
If you flash this firmware without setting the required U-Boot environment variables, your router will be bricked.
In that case, you can recover it by following these steps listed in the official GL.iNet documentation [here](https://docs.gl-inet.com/router/en/4/faq/debrick/).


## About Custom Attended Sysupgrade

Using Luci's menu "System" --> "Attended Sysupgrade" it is now possible to select and install custom firmware from GitHub.
  
<sub>Custom Attended Sysupgrade</sub>  
![Custom Attended Sysupgrade](attended-sysupgrade-custom.png)
  
<sub>Dropdown list</sub>  
![Dropdown list](attended-sysupgrade-releases.png)
  
<sub>Installing Custom Firmware</sub>  
![Installing Custom Firmware](attended-sysupgrade-installing.png)
  
<sub>GitHub repository</sub>  
![GitHub repository used](attended-sysupgrade-server.png)
  
Notes:
- if you fork this repository, this will be adapted to look for upgrades in your repository by default.



## About upgrade_custom_openwrt script

```
THIS IS NOW DEPRECATED, ALTHOUGHT THE SCRIPT IS STILL INCLUDED
```

I added a script to make upgrading OpenWRT super easy. Just run from a SSH terminal:
- `upgrade_custom_openwrt --now` to check if a newer firmware is available and upgrade if so.
- `upgrade_custom_openwrt --wait` to wait for clients activity to stop before upgrading.
- `upgrade_custom_openwrt --check` to check for new versions but not upgrade the router.

**IT IS NOT RECOMMENDED** to schedule the script to be executed automatically, although the script is very careful and checks sha256sums before trying to upgrade. Don't blame me if something goes wrong with scripts that **YOU** run in your router!

Notes:
- if you fork this repository, the script will be adapted to look for upgrades in your repository.
- The text output of upgrade_custom_openwrt script will show both in terminal and system logs.


## Contributing

Contributions to this project are welcome. If you encounter any issues or have suggestions for improvements, please open an issue or submit a pull request on the GitHub repository.



## Acknowledgements

- The OpenWrt project for providing the foundation for this firmware build and support of [GL.iNet GL-MT6000](https://openwrt.org/toh/gl.inet/gl-mt6000) router.
- The community over at the [OpenWrt forum](https://forum.openwrt.org/t/mt6000-custom-build-with-luci-and-some-optimization-kernel-6-12-x/185241) for their valuable contributions and resources. 
- [pesa1234](https://github.com/pesa1234) for his [MT6000 custom builds](https://github.com/pesa1234/MT6000_cust_build).
- [Julius Bairaktaris](https://github.com/JuliusBairaktaris/Qualcommax_NSS_Builder) from whom I "borrowed" much of this project (his repository is about custom builds for Xiaomi AX3600).
- [cjom](https://github.com/cjom) From where I forked this repository
