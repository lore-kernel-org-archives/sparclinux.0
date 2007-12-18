From: =?ISO-8859-1?Q?BERTRAND_Jo=EBl?= <joel.bertrand@systella.fr>
Date: Tue, 18 Dec 2007 08:33:46 +0000
Subject: [sparc64] 2.6.23.x kernel and udev on U2E
Message-Id: <476785EA.8030906@systella.fr>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

	Hello,

	I have seen a very strange timeout when my U2E boots. I use the same 
kernel (2.6.23.11) on all my sparc64. On U60, U80, U420R, T1000, it 
boots fine, but on my U2E (2*300 MHz, 2GB), boot process waits for a 
timeout when udev is started:

Waiting for /dev/to be fully populated
sr0: scsi-1 drive
Uniform CD-ROM driver Revision: 3.20
sr 0:0:6:0: Attached scsi CD-ROM sr0
sd 0:0:0:0: Attached scsi generic sg0 type 0
sd 0:0:1:0: Attached scsi generic sg1 type 0
sr 0:0:6:0: Attached scsi generic sg2 type 5
done(timeout)

I have a offline scanner (snapscan 1236s) on same SCSI interface. If I 
disconnect this scanner, I see the same trouble. After this timeout (2 
ou 3 minutes, maybe more...), boot process continues and I can see that 
load average was greater than 60!

If I restart udev, it is restarted without any timeout. I don't 
understand where is the mistake (PCI support ?). It seems to be a bad 
interaction between udev and kernel but I don't know the last 
configuration where kernel and udev work fine together. I have trie to 
find an old configuration that boots without this timeout without any 
success. I don't understand why with exactly the same .config I cannot 
see the same trouble on my U60.

	Regards,

	JKB
