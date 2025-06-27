echo "cài ngrok"
sudo su
curl -sSL https://ngrok-agent.s3.amazonaws.com/ngrok.asc \
  | tee /etc/apt/trusted.gpg.d/ngrok.asc >/dev/null \
  && echo "deb https://ngrok-agent.s3.amazonaws.com buster main" \
  | tee /etc/apt/sources.list.d/ngrok.list \
  && apt update \
  && apt install ngrok > /dev/null 2>&1
ngrok config add-authtoken 2MWv85utwyi9ItXxwvdn948ytGR_7q5h1JLXmpMiyW1v4mXZn  
nohup ngrok tcp 3389 &>/dev/null &
echo "cài qemu"
sudo su
apt update
apt install qemu-kvm -y
echo "Windows datnguyen"
sudo su
wget -O win.img "http://drive.muavps.net/file/Windows2022.img"
echo Your VNC IP Address:
curl --silent --show-error http://127.0.0.1:4040/api/tunnels | sed -nE 's/.*public_url":"tcp:..([^"]*).*/\1/p'
echo "Note: Use Right-Click Or Ctrl+C To Copy"
echo "Please Keep Colab Tab Open, Maximum Time 12h"
echo "chạy vps"
sudo qemu-system-x86_64 -M q35 -usb -device qemu-xhci -device usb-tablet -device usb-kbd -cpu host,+pae -smp sockets=4,cores=4,threads=2 -m 24576M  -drive format=raw,file=win.img -vga std -device ich9-intel-hda -device hda-duplex -device virtio-net-pci,netdev=n0 -netdev user,id=n0,hostfwd=tcp::3389-:3389 -accel kvm -device virtio-serial-pci -device e1000e,netdev=n0 -netdev user,id=n0 -net nic -net -device intel-iommu -vnc :0
