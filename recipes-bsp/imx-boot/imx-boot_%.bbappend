inherit hilscher-deploy

hd_path = "${HDEPLOY_PATH_EXTRAS}/bootloader"

do_hilscher_deploy() {
        cd ${DEPLOYDIR}
        cp -a $(readlink imx-boot) ${hd_path}/
}
do_hilscher_deploy[cleandirs] = "${hd_path}/"
addtask hilscher_deploy before do_build after do_deploy
