/* config of hilscher-ucm-imx8m-mini */

/* default is 4 which lead to connection trouble (dhcp/bootp) in some network setups */
#ifdef CONFIG_BOOTP_ID_CACHE_SIZE
	#undef CONFIG_BOOTP_ID_CACHE_SIZE
	#define CONFIG_BOOTP_ID_CACHE_SIZE 10
#endif

#if defined(CONFIG_IMX_HAB)
	/* Platform specific initialization */
	#define PLATFORM_INIT \
		"setenv basebootargs console=${console} rootwait rw rootdelay=1 roottimeout=10 loglevel=4; " \
		"setenv fdt_addr ${loadaddr}; " \
		"part number $plat_dev_if $plat_dev boot plat_boot_part; " \
		"part number $plat_dev_if $plat_dev system plat_system_part; " \
		"usb reset; " \
		"part number $usb_dev_if $usb_dev recovery usb_recovery_part; " \
		"hab_status"
#else
	/* Platform specific initialization */
	#define PLATFORM_INIT \
		"setenv basebootargs console=${console} rootwait rw rootdelay=1 roottimeout=10 loglevel=4; " \
		"setenv fdt_addr ${loadaddr}; " \
		"part number $plat_dev_if $plat_dev boot plat_boot_part; " \
		"part number $plat_dev_if $plat_dev system plat_system_part; " \
		"usb reset; " \
		"part number $usb_dev_if $usb_dev recovery usb_recovery_part; "
#endif

/* Platform specific environment settings */
#define BASE_BOARD_CONFIG_EXTRA_ENV_SETTINGS \
	"basebootargs=dummy - see platform_init\0" \
	"plat_dev_if=mmc\0" \
	"plat_dev=1\0" \
	"plat_dev_linux=/dev/mmcblk1p\0" \
	"usb_dev_if=usb\0" \
	"usb_dev=0\0" \
	"get_menu= \0"

/* definition not necesarry since control is done via keyboard, screen, serial... */
#define BOARD_CONFIG_EXTRA_ENV_SETTINGS \
	BASE_BOARD_CONFIG_EXTRA_ENV_SETTINGS
