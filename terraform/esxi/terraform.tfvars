vsphere_server = "192.168.1.2"
vsphere_user   = "root"
# vsphere_password wordt meegegeven via GitHub Secret: TF_VAR_vsphere_password

datastore      = "datastore1"
network        = "VM Network"
ova_path       = "/home/student/noble-server-cloudimg-amd64.ova"
admin_user     = "student"
ssh_pubkey     = "/home/student/.ssh/skylab.pub"
disk_gb        = 10
ip_output_file = "/tmp/week6_esxi_ip.txt"
