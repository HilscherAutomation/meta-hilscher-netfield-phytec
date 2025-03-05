=====================
netfield-quantum-rev1
=====================

.. :Author: Frank Meisenbach <fmeisenbach@hilscher.com>

+--------------+-------------------------------------+
| Name         | netFIELD Quantum / NFX8N-D4-N32-016 |
+--------------+-------------------------------------+
| Ordernumber  | 1918.016                            |
+--------------+-------------------------------------+
| Machine      | netfield-quantum-rev1               |
+--------------+-------------------------------------+

.. contents::
   :local:
   :backlinks: top
   :depth: 2

Features
========
 - 2x GBit Ethernet
 - 1x TPM2.0
 - 4x DI
 - 4x DO
 - 4x User LEDs
 - 4x LEDs (usually used by Cloud/Edge software)
 - 1x CAN
 - 1x RS485 (alternatively RS232)
 - 1x uSD Slot for data storage
 - 1x HDMI Port for display applications (e.g. HMI)
 - 4x DIP Switch (internal)

Hardware options / assignments
==============================

Power Connector (X1)
--------------------

 +-----+------------------------------+------------------------------------------------------------+----------------------------------------+
 + Pin | Singal name                  | Description                                                | Remark                                 |
 +=====+==============================+============================================================+========================================+
 |  1  | GND                          |                                                            |                                        |
 +-----+------------------------------+------------------------------------------------------------+----------------------------------------+
 |  2  | VCC24V,                      |                                                            | separately protected by a 3.5A fuse    |
 |     |                              |                                                            |                                        |
 |     | VCC24V_OUTPUT                |                                                            | separately protected by a 3.5A fuse    |
 +-----+------------------------------+------------------------------------------------------------+----------------------------------------+


I/O Connector (X9)
------------------

 +-----+------------------------------+------------------------------------------------------------+-------------------------------------------+----------------------------------------+
 + Pin | Singal name                  | Description                                                | Remark                                    |                                        |
 +=====+==============================+============================================================+===========================================+========================================+
 |  1  | DOUT2                        | High-side switch referenced to VCC24V_OUTPUT and GND       | Max. Current:                             | /var/platform/out_dout2                |
 |     |                              |                                                            |   500mA                                   |                                        |
 |     |                              |                                                            |                                           | /var/platform/in_ndout2_st             |
 |     |                              |                                                            | Load Types:                               | (Diagnostic-Pin)                       |
 +-----+------------------------------+------------------------------------------------------------+   inductive, capacitive, resistive        +----------------------------------------+
 |  2  | DOUT1                        | High-side switch referenced to VCC24V_OUTPUT and GND       |                                           | /var/platform/out_dout1                |
 |     |                              |                                                            | Protection Features:                      |                                        |
 |     |                              |                                                            |   - UVLO                                  | /var/platform/in_ndout1_st             |
 |     |                              |                                                            |   - Loss-of-GND                           | (Diagnostic-Pin)                       |
 +-----+------------------------------+------------------------------------------------------------+   - Loss-of-Power                         +----------------------------------------+
 |  3  | DOUT4                        | High-side switch referenced to VCC24V_OUTPUT and GND       |   - Reverse-Current                       | /var/platform/out_dout4                |
 |     |                              |                                                            |   - MCU I/O                               |                                        |
 |     |                              |                                                            |                                           | /var/platform/in_ndout4_st             |
 |     |                              |                                                            | Diagnostic Features [#f1]_:               | (Diagnostic-Pin [#f1]_)                |
 +-----+------------------------------+------------------------------------------------------------+   - Overcurrent                           +----------------------------------------+
 |  4  | DOUT3                        | High-side switch referenced to VCC24V_OUTPUT and GND       |   - Short-to-Supply, Reverse-Polarity     | /var/platform/out_dout3                |
 |     |                              |                                                            |   - Thermal-Shutdown [#f2]_               |                                        |
 |     |                              |                                                            |                                           | /var/platform/in_ndout3_st             |
 |     |                              |                                                            |                                           | (Diagnostic-Pin [#f1]_)                |
 +-----+------------------------------+------------------------------------------------------------+-------------------------------------------+----------------------------------------+
 |  5  | DIN4                         | Isolated input referenced to VCC24V_OUTPUT and GND         |                                           | /var/platform/in_din4                  |
 +-----+------------------------------+------------------------------------------------------------+-------------------------------------------+----------------------------------------+
 |  6  | DIN3                         | Isolated input referenced to VCC24V_OUTPUT and GND         |                                           | /var/platform/in_din3                  |
 +-----+------------------------------+------------------------------------------------------------+-------------------------------------------+----------------------------------------+
 |  7  | DIN2                         | Isolated input referenced to VCC24V_OUTPUT and GND         |                                           | /var/platform/in_din2                  |
 +-----+------------------------------+------------------------------------------------------------+-------------------------------------------+----------------------------------------+
 |  8  | DIN1                         | Isolated input referenced to VCC24V_OUTPUT and GND         |                                           | /var/platform/in_din1                  |
 +-----+------------------------------+------------------------------------------------------------+-------------------------------------------+----------------------------------------+
 |  9  | GND_ISO                      |                                                            |                                           |                                        |
 +-----+------------------------------+------------------------------------------------------------+-------------------------------------------+----------------------------------------+
 | 10  | CANL                         |                                                            |                                           |                                        |
 +-----+------------------------------+ Isolated CAN-Interface referenced to GND_ISO               + unterminated                              + can0                                   +
 | 11  | CANH                         |                                                            |                                           |                                        |
 +-----+------------------------------+------------------------------------------------------------+-------------------------------------------+----------------------------------------+
 | 12  | RS485_RX-                    |                                                            | Multiplexed output pins                   | /dev/ttymxc1                           |
 +-----+------------------------------+ Isolated UART2-Interface referenced to GND_ISO             +                                           +                                        +
 | 13  | RS485_RX+/RS232_RXD          |                                                            |                                           | /var/platform/sel_uart2_rs485_nrs232   |
 |     |                              |                                                            |                                           | (Select-Pin: 0=RS232, 1=RS485)         |
 +-----+------------------------------+------------------------------------------------------------+-------------------------------------------+----------------------------------------+
 | 14  | GND_ISO                      |                                                            |                                           |                                        |
 +-----+------------------------------+------------------------------------------------------------+-------------------------------------------+----------------------------------------+
 | 15  | RS485_TX+                    |                                                            | Multiplexed output pins                   | /dev/ttymxc1                           |
 +-----+------------------------------+ Isolated UART2-Interface referenced to GND_ISO             +                                           +                                        +
 | 16  | RS485_TX-/RS232_TXD          |                                                            |                                           | /var/platform/sel_uart2_rs485_nrs232   |
 |     |                              |                                                            |                                           | (Select-Pin: 0=RS232, 1=RS485)         |
 +-----+------------------------------+------------------------------------------------------------+-------------------------------------------+----------------------------------------+

 .. [#f1] The Diagnostic-Feature can be hardwire "enabled"/"disabled" (see J3 in schematic, **default off**).
 .. [#f2] The Thermal-Shutdown feature can be hardwire configured to "latch off"/"auto-retry" (see J4 in schematic, **default auto-retry**).

 .. TODO::
   #. Diagnostic Features enabled/disabled?
      **NOTE: If disabled, the diagnostic pins are useless.**
   #. Thermal-Shutdown Feature latch-off/auto-retry?
   #. Imax is currently 900mA instead of 500mA (see schematic: text "500mA pro Kanal" vs. adjustment by R639)!?
      **NOTE: The power supply for all 4 outputs is currently protected by a 3,5A fuse!**


Internal DIP Switches (S3)
--------------------------

 The device has 4 internal DIP switches which are currently not used by any software component.
 They are accessible via /sys/class/gpio or via symlinks in /var/platform.

 +--------+---------------+-----------------------+----------------------------+
 + Ref.   | Signal name   | Description           |                            |
 +========+===============+=======================+============================+
 | S3.1   | DIP_IN1       | for general purpose   | /var/platform/in_dip_in1   |
 +--------+---------------+-----------------------+----------------------------+
 | S3.2   | DIP_IN2       | for general purpose   | /var/platform/in_dip_in1   |
 +--------+---------------+-----------------------+----------------------------+
 | S3.3   | DIP_IN3       | for general purpose   | /var/platform/in_dip_in1   |
 +--------+---------------+-----------------------+----------------------------+
 | S3.4   | DIP_IN4       | for general purpose   | /var/platform/in_dip_in1   |
 +--------+---------------+-----------------------+----------------------------+


LEDs
----

 +------+------------------------------+------------------------------------------------------------+-------------------------------------------+----------------------------------------+
 + Ref. | Singal name                  | Description                                                | Remark                                    |                                        |
 +======+==============================+============================================================+===========================================+========================================+
 |      |                              | Green power LED                                            | Direct connected to VDD_IO_3V3            |                                        |
 + D80  +------------------------------+------------------------------------------------------------+-------------------------------------------+----------------------------------------+
 |      | LED1_ACT                     | Yellow heartbeat LED                                       | Triggered by linux kernel                 |                                        |
 +------+------------------------------+------------------------------------------------------------+-------------------------------------------+----------------------------------------+
 |      | LED3_EDG_G                   | Green LED used by edge services                            |                                           |                                        |
 + D82  +------------------------------+------------------------------------------------------------+ Controlled by docker container            +----------------------------------------+
 |      | LED3_EDG_Y                   | Yellow LED used by edge services                           |                                           |                                        |
 +------+------------------------------+------------------------------------------------------------+-------------------------------------------+----------------------------------------+
 |      | LED4_CLD_R                   | The Red/Green cloud LED shows the onboarding state of      |                                           |                                        |
 + D139 +------------------------------+ the azure runtime.                                         + Controlled by machine-state.service       +----------------------------------------+
 |      | LED4_CLD_G                   |                                                            |                                           |                                        |
 +------+------------------------------+------------------------------------------------------------+-------------------------------------------+----------------------------------------+
 |      | LED5_USR1_G                  | Green LED for general purpose                              |                                           | /var/platform/led_usr1_green           |
 + D83  +------------------------------+------------------------------------------------------------+-------------------------------------------+----------------------------------------+
 |      | LED5_USR1_Y                  | Yellow LED for general purpose                             |                                           | /var/platform/led_usr1_yellow          |
 +------+------------------------------+------------------------------------------------------------+-------------------------------------------+----------------------------------------+
 |      | LED6_USR2_G                  | Green LED for general purpose                              |                                           | /var/platform/led_usr2_green           |
 + D84  +------------------------------+------------------------------------------------------------+-------------------------------------------+----------------------------------------+
 |      | LED6_USR2_Y                  | Yellow LED for general purpose                             |                                           | /var/platform/led_usr2_yellow          |
 +------+------------------------------+------------------------------------------------------------+-------------------------------------------+----------------------------------------+
 |      | mPCI_WWAN                    | Red LED used for WWAN by the mPCI card                     | Hardwired to mPCI socket                  |                                        |
 + D140 +------------------------------+------------------------------------------------------------+-------------------------------------------+----------------------------------------+
 |      | mPCI_WLAN                    | Green LED used for WLAN by the mPCI card                   | Hardwired to mPCI socket                  |                                        |
 +------+------------------------------+------------------------------------------------------------+-------------------------------------------+----------------------------------------+
 
 .. NOTE::
   #. Except for the mPCI LEDs, the LEDs are exposed in /sys/class/led (see https://docs.kernel.org/leds/leds-class.html).
   #. The LEDs used for general purpose are also exposed as symlink in /var/platform.
 
 .. TODO::
   #. Should the mPCI_WWAN LED really be red?


ETH0 with TSN (X2)
------------------

 - Fully compatible to IEEE 802.3 10BASE-Te, 100BASE-TX, and 1000BASE-T Specification
 - Time Sensitive Network (TSN) compliant
 - IEEE 1588 Start of Frame Detection
 - WoL (Wake-on-LAN) packet detection
 - Cable diagnostics
 - Exceeds 8000V IEC 61000-4-2 ESD protection

 .. TODO::
  #. There is a SYNCCLK connected from PHY to GPIO1_IO7. What is the purpose of this pin?
  #. Should this pin be deactivated if possible to facilitate EMC testing?


ETH1 (X3)
---------

 .. TODO::
   Replace this TODO by a feature description!


CAN Interface (see I/O Connector (X9))
--------------------------------------

 There is a single can port on the device that can be used via socket CAN (https://docs.kernel.org/networking/can.html) by any container.

 Examples:

   .. code-block::

     ip link set can0 type can bitrate 125000
     ip link set can0 up
     cansend can0 11 22 33 44 AA BB CC DD

   .. code-block::

     ip link set can0 type can bitrate 125000
     ip link set can0 up
     candump can0

   .. code-block::

     ip -details -statistic link show can0


RS485/RS232 (see I/O Connector (X9))
------------------------------------

 A combined (switchable) UART port is available as /dev/ttymxc1.
 The mode of this can be switched via a GPIO Pin exposed as /var/platform/sel_uart_rs485_nrs232 which defaults to RS485 mode.

 +--------------------------+-----------------+
 + sel_uart2_rs485_nrs232   | Mode            |
 +==========================+=================+
 | 0                        | RS232           |
 +--------------------------+-----------------+
 | 1                        | RS485 (default) |
 +--------------------------+-----------------+

 **Specification:**

   - SP330 transceiver

   - 20Mbps RS-485 and 1Mbps RS-232 Data Rates

   - Robust ESD Protection

     - ±15kV IEC 61000-4-2 Air Gap Discharge
     - ± 8kV IEC 61000-4-2 Contact Discharge
     - ±15kV Human Body Model (HBM)

 .. TODO::
   #. Should the RS485 inferface really be a full-duplex interface (4-wires)?

uSD-Card (X4)
-------------

 An external uSD-Card can be inserted which is automatically mounted to `/mnt/extsd` for storing application data.
 It will not be used by the system in any way per default.


TPM
---
 Usable via /dev/tpm0 or /dev/tpmrm0 by any application.

 Can optionally be used for cloud onboarding


HDMI (X52)
----------

 The HDMI port can be used by any container. The base system does not provide any graphics library or X-Server.
 Make sure your container can access the DRM device.


Initial Prototype Tests
=======================

 +-------------+---------------------------------+-------------------------------------------------------------+----------+--------------+
 | Test-No.    | Description                     | Remark                                                      | Result   | Date/Sign    |
 +=============+=================================+=============================================================+==========+==============+
 | 1           | Serial console port (X12)       | Tested via debug console terminal                           |   okay   | 20250227/FME |
 |             |                                 | (adapter required)                                          |          |              |
 +-------------+---------------------------------+-------------------------------------------------------------+----------+--------------+
 | 2           | eth0 (X2) link-up/down, tx/rx   | Tested via swupdate upload                                  |   okay   | 20250227/FME |
 +-------------+---------------------------------+-------------------------------------------------------------+----------+--------------+
 | 3           | eth1 (X3) link-up/down, tx/rx   | Tested via swupdate upload                                  |   okay   | 20250227/FME |
 +-------------+---------------------------------+-------------------------------------------------------------+----------+--------------+
 | 4           | DOUT[1..4] (X9)                 | echo 1 > /var/platform/out_doutX                            |   okay   | 20250227/FME |
 |             |                                 |                                                             |          |              |
 |             |                                 | Check desired DOUT pin with DVM (should be 24V)             |          |              |
 +-------------+---------------------------------+-------------------------------------------------------------+----------+--------------+
 | 5           | DIN[1..4] (X9)                  | Connect desired DIN pin to VCC24V_OUTPUT (X1)               |   okay   | 20250227/FME |
 |             |                                 |                                                             |          |              |
 |             |                                 | cat /var/platform/in_DINx (should be 1)                     |          |              |
 +-------------+---------------------------------+-------------------------------------------------------------+----------+--------------+
 | 6           | DIP_IN[1..4] (S3)               | Switch desired switch off                                   |   okay   | 20250227/FME |
 |             |                                 |                                                             |          |              |
 |             |                                 | cat /var/platform/in_dip_inX (should be 0)                  |          |              |
 |             |                                 |                                                             |          |              |
 |             |                                 | Switch desired switch on                                    |          |              |
 |             |                                 |                                                             |          |              |
 |             |                                 | cat /var/platform/in_dip_inX (should be 1)                  |          |              |
 +-------------+---------------------------------+-------------------------------------------------------------+----------+--------------+
 | 7           | LEDs                            | echo 1 > /sys/class/led/.../brightness => desired LED on    |   okay   | 20250303/FME |
 |             |                                 |                                                             |          |              | 
 |             |                                 | echo 0 > /sys/class/led/.../brightness => desired LED off   |          |              |
 +-------------+---------------------------------+-------------------------------------------------------------+----------+--------------+
 | 8           | CAN (X9) tx/rx                  | Connect CAN interface to second device                      |   okay   | 20250227/FME |
 |             |                                 | (think about the termination and GND_ISO)                   |          |              |
 |             |                                 |                                                             |          |              |
 |             |                                 | ip link set can0 type can bitrate 125000                    |          |              |
 |             |                                 |                                                             |          |              |
 |             |                                 | ip link set can0 up                                         |          |              |
 |             |                                 |                                                             |          |              |
 |             |                                 | candump can0                                                |          |              |
 |             |                                 |                                                             |          |              |
 |             |                                 | cansend can0 0x11 0x22 0x33 0x44 0xaa 0xbb 0xcc 0xdd        |          |              |
 |             |                                 |                                                             |          |              |
 |             |                                 | ip -details -statistic link show can0                       |          |              |
 +-------------+---------------------------------+-------------------------------------------------------------+----------+--------------+
 | 9           | RS232 (X9)                      | echo 0 > /var/platform/sel_uart_rs485_nrs232                |   okay   | 20250305/FME |
 |             |                                 |                                                             |          |              |
 |             |                                 | connect RS232 to X9 and open a terminal application         |          |              |
 |             |                                 |                                                             |          |              |
 |             |                                 | getty ttymxc1 115200                                        |          |              |
 +-------------+---------------------------------+-------------------------------------------------------------+----------+--------------+
 | 10          | RS485 (X9)                      | echo 1 > /var/platform/sel_uart_rs485_nrs232                |          |              |
 |             |                                 |                                                             |          |              |
 |             |                                 | connect RS485 to X9 and open a terminal application         |          |              |
 |             |                                 |                                                             |          |              |
 |             |                                 | getty ttymxc1 115200                                        |          |              |
 +-------------+---------------------------------+-------------------------------------------------------------+----------+--------------+
 | 11          | USB 2.0 (X7)                    | journalctl -f                                               |   okay   | 20250227/FME |
 |             |                                 |                                                             |          |              |
 |             |                                 |   - connect a USB-Stick =>                                  |          |              |
 |             |                                 |     usb-storage 3-1.1:1.0: USB Mass Storage device detected |          |              |
 |             |                                 |   - disconnect the USB-Stick =>                             |          |              |
 |             |                                 |     usb 3-1.1: USB disconnect, device number ...            |          |              |
 +-------------+---------------------------------+-------------------------------------------------------------+----------+--------------+
 | 12          | USB 3.0 (X6)                    | journalctl -f                                               |   okay   | 20250227/FME |
 |             |                                 |                                                             |          |              |
 |             |                                 |   - connect a USB-Stick =>                                  |          |              |
 |             |                                 |     usb-storage 2-1:1.0: USB Mass Storage device detected   |          |              |
 |             |                                 |   - disconnect the USB-Stick =>                             |          |              |
 |             |                                 |     usb 2-1: USB disconnect, device number ...              |          |              |
 |             |                                 |                                                             |          |              |
 |             |                                 | cat /var/platform/in_usb3_phy0_nfault (should be 1)         |          |              |
 |             |                                 |                                                             |          |              |
 |             |                                 | create an overload to the USB-Port                          |          |              |
 |             |                                 |                                                             |          |              |
 |             |                                 | cat /var/platform/in_usb3_phy0_nfault (should be 0)         |          |              |
 +-------------+---------------------------------+-------------------------------------------------------------+----------+--------------+
 | 13          | SD-Card                         | insert sd-card => mounted partitions on /mnt/extsd/         |   okay   | 20250303/FME |
 |             |                                 |                                                             |          |              | 
 |             |                                 | remove sd-card => /mnt/extsd should be removed              |          |              |
 +-------------+---------------------------------+-------------------------------------------------------------+----------+--------------+
 | 14          | M2 slot (X54)                   |                                                             |          |              |
 |             |                                 |                                                             |          |              |
 +-------------+---------------------------------+-------------------------------------------------------------+----------+--------------+
 | 15          | mPCI slot (X11)                 |                                                             |          |              |
 |             |                                 |                                                             |          |              |
 +-------------+---------------------------------+-------------------------------------------------------------+----------+--------------+
 | 16          | HDMI (X52)                      |                                                             |          |              |
 +-------------+---------------------------------+-------------------------------------------------------------+----------+--------------+
