From: Dmitry Artamonow <mad_soft@inbox.ru>
Date: Fri, 04 May 2007 16:16:47 +0000
Subject: SILO-1.4.13 and degraded RAID1 issue
Message-Id: <20070504161647.GA11063@sunflower.office.asoft.ru>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="2oS5YaxWCcQjTEyO"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Good day!

Some time ago I found that my HDD in U10 is going to die so I decided to 
migrate my rootfs to second disk running in degraded RAID1 mode 
(I planned to replace broken HDD later for creating complete RAID1 mirror)
I used methodics described here:
http://gentoo-wiki.com/HOWTO_Migrate_To_RAID#Migrating_from_no_RAID_to_RAID-1

I created degraded RAID on second disk and copied rootfs onto it,
then replaced 'root=/dev/hda1' with 'root=/dev/md1' in /etc/silo.conf
and rebooted computer.

After succesful reboot I tried to reinstall SILO loader on degraded RAID
(i.e. second HDD) to get rid of the first (broken) HDD, which was still
used for booting. But when I issued `silo` I got this message:

sunflower ~ # silo
/etc/silo.conf appears to be valid
Fatal error: No non-faulty disks found in RAID1

Here's the contents of my silo.conf:

sunflower ~ # cat /etc/silo.conf | grep -v "^\#" | grep -v '^$'
partition = 1
root = /dev/md1
timeout = 100
image = /boot/kernel-2.6.16.20
        label = linux-2.6.16.20
image = /boot/2.6.16.19
        label = linux

And here's my RAID config:

sunflower ~ # cat /etc/mdadm.conf  | grep -v "^\#" | grep -v '^$'
ARRAY /dev/md1 level=raid1 num-devices=2
+UUID=f1fbc4ce:a04bf77c:3198d8f6:043776c8
ARRAY /dev/md2 level=raid1 num-devices=2
+UUID=b225d38c:dd66032e:e6b0c497:97ce7adf
ARRAY /dev/md3 level=raid1 num-devices=2
+UUID=6768152f:04222a1a:d00871c9:68547878
ARRAY /dev/md4 level=raid1 num-devices=2
+UUID=1252ad0d:44bf5027:48510843:842236b4
ARRAY /dev/md5 level=raid1 num-devices=2
+UUID=22bdc48f:4902e0b5:66887282:984d65db

sunflower ~ # cat /proc/mdstat
Personalities : [raid1]
md1 : active raid1 hdc1[1]
      987904 blocks [2/1] [_U]

md2 : active raid1 hdc2[1]
      995904 blocks [2/1] [_U]

md3 : active raid1 hdc4[1]
      4000064 blocks [2/1] [_U]

md4 : active raid1 hdc5[1]
      2000000 blocks [2/1] [_U]

md5 : active raid1 hdc6[1]
      32194176 blocks [2/1] [_U]

unused devices: <none>


I looked into silo.c and found this code snippet:
----------------------------------------------------------------------------
1004:   case 9:         /* RAID device */
1005:           {
1006:                   md_array_info_t md_array_info;
1007:                   md_disk_info_t md_disk_info;
1008:                   int md_fd, i, id = 0;
1009:                   struct hwdevice *d, *last;
1010: 
1011:                   sprintf (dev, "/dev/md%d", minno);
1012:                   md_fd = devopen (dev, O_RDONLY);
1013:                   if (md_fd < 0)
1014:                           silo_fatal("Could not open RAID device");
1015:                   if (ioctl (md_fd, GET_ARRAY_INFO, &md_array_info) < 0)
1016:                           silo_fatal("Could not get RAID array info");
1017:                   if (md_array_info.major_version == 0 && md_array_info.minor_version < 90)
1018:                           silo_fatal("Raid versions < 0.90 are not "
1019:                                      "supported");
1020:                   if (md_array_info.level != 1)
1021:                           silo_fatal("Only RAID1 supported");
1022:                   hwdev = NULL;
1023:                   last = NULL;
1024:                   for (i = 0; i < md_array_info.nr_disks; i++) {
1025:                           if (i == md_array_info.nr_disks - 1 && md_disk_info.majorno == 0 &&
1026:                               md_disk_info.minorno == 0)
1027:                                   break; // That's all folks
1028:                           md_disk_info.number = i;
1029:                           if (ioctl (md_fd, GET_DISK_INFO, &md_disk_info) < 0)
1030:                                   silo_fatal("Could not get RAID disk "
1031:                                              "info for disk %d\n", i);
1032:                           if(md_disk_info.majorno != 0 && md_disk_info.minorno != 0) {
1033:                                   d = get_device (md_disk_info.majorno, md_disk_info.minorno);
1034:                                   if (md_disk_info.state == MD_DISK_FAULTY) {
1035:                                           printf ("disk %s marked as faulty, skipping\n", d->dev);
1036:                                           continue;
1037:                                   }
1038:                                   if (hwdev)
1039:                                           last->next = d;
1040:                                   else
1041:                                           hwdev = d;
1042:                                   while (d->next != NULL) d = d->next;
1043:                                   last = d;
1044:                           }
1045:                   }
1046:                   if (!hwdev)
1047:                           silo_fatal("No non-faulty disks found "
1048:                                      "in RAID1");
1049:                   for (d = hwdev; d; d = d->next)
1050:                           d->id = id++;
1051:                   raid1 = id;
1052:                   close (md_fd);
1053:                   return hwdev;
1054:           }
----------------------------------------------------------------------------

'md_disk_info' structure created on line 1007 used uninitialised in 
'if' statement on line 1025. And because md_array_info.nr_disks = 1 in 
my case of degraded RAID1, SILO leaves the loop and goes directly to 
lines 1046 and then 1047, where aforementioned error message is printed. 
Because meaning of this 'if' on line 1025 was unclear to me, I simply 
commented it out, but still got the same result. 
After some investigations I found that md_array_info.nr_disks = 1 is 
number of good disks in the array. And since my HDD is second in the 
array from SILO's point of view, it couldn't be found in searching 
loop (lines 1024-1045). Also I discovered experimentally that total 
number of disks in array (both good and bad) seems to be stored in 
'md_array_info.raid_disks'. I replaced 'md_array_info.nr_disks' with 
'md_array_info.raid_disks' on line 1024 and SILO installed bootloader 
succesfully. 


So, that's all folks! 
Patch with all of my changes to silo.c attached. 
It works for me :)

Best regards,
Dmitry 'MAD' Artamonow



--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="silo_degraded_raid1.patch"

--- silo-1.4.13/silo/silo.c	2006-06-01 21:24:53.000000000 +0400
+++ silo-1.4.13-mad/silo/silo.c	2007-05-04 19:43:12.000000000 +0400
@@ -1021,10 +1021,7 @@
 				silo_fatal("Only RAID1 supported");
 			hwdev = NULL;
 			last = NULL;
-			for (i = 0; i < md_array_info.nr_disks; i++) {
-				if (i == md_array_info.nr_disks - 1 && md_disk_info.majorno == 0 &&
-				    md_disk_info.minorno == 0)
-					break; // That's all folks
+			for (i = 0; i < md_array_info.raid_disks; i++) {
 				md_disk_info.number = i;
 				if (ioctl (md_fd, GET_DISK_INFO, &md_disk_info) < 0)
 					silo_fatal("Could not get RAID disk "

--2oS5YaxWCcQjTEyO--
