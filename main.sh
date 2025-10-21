sudo mv test.service /etc/systemd/system/test.service
sudo mv test.sh /usr/local/bin/test.sh
sudo chmod +x /usr/local/bin/test.sh
sudo systemctl daemon-reload
sudo systemctl start test.service

sudo mv process_monitor.service /etc/systemd/system/process_monitor.service
sudo mv monitor.sh /usr/local/bin/monitor.sh
sudo chmod +x /usr/local/bin/monitor.sh
sudo mv process_monitor.timer /etc/systemd/system/process_monitor.timer

sudo systemctl daemon-reload
sudo systemctl start process_monitor.service
sudo systemctl start process_monitor.timer