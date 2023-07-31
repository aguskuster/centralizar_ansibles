echo "[BkBases]" >> /etc/samba/smb.conf
echo "comment = directorio compartido con samba" >> /etc/samba/smb.conf
echo "path = /home/bkp">> /etc/samba/smb.conf
echo "valid users = bkp">> /etc/samba/smb.conf
echo "public = no" >> /etc/samba/smb.conf
echo "writable = yes" >> /etc/samba/smb.conf