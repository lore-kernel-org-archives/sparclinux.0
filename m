From: Nicolas Boullis <nboullis@debian.org>
Date: Sat, 30 Oct 2004 23:28:51 +0000
Subject: Re: PATCH to fix smbfs on sparc64
Message-Id: <20041030232851.GB5207@tintin>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="FL5UXtIhxfXey3p5"
List-Id: <sparclinux.vger.kernel.org>
References: <20041030232157.GA5207@tintin>
In-Reply-To: <20041030232157.GA5207@tintin>
To: sparclinux@vger.kernel.org


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hmmm....

As usual, I stupidly forgot to attach the promised patch. Here it is (if 
I don't forget again).


Sorry for the extraneous noise,

Nicolas

--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-2.4.27-smbfs.patch"

diff -ruN linux-2.4.27/arch/sparc64/kernel/ioctl32.c linux-2.4.27-smbfs/arch/sparc64/kernel/ioctl32.c
--- linux-2.4.27/arch/sparc64/kernel/ioctl32.c	2004-08-08 01:26:04.000000000 +0200
+++ linux-2.4.27-smbfs/arch/sparc64/kernel/ioctl32.c	2004-10-31 00:58:20.000000000 +0200
@@ -4928,6 +4928,7 @@
 COMPATIBLE_IOCTL(RAW_GETBIND)
 /* SMB ioctls which do not need any translations */
 COMPATIBLE_IOCTL(SMB_IOC_NEWCONN)
+COMPATIBLE_IOCTL(SMB_IOC_GETMOUNTUID32)
 /* NCP ioctls which do not need any translations */
 COMPATIBLE_IOCTL(NCP_IOC_CONN_LOGGED_IN)
 COMPATIBLE_IOCTL(NCP_IOC_SIGN_INIT)
diff -ruN linux-2.4.27/fs/smbfs/ioctl.c linux-2.4.27-smbfs/fs/smbfs/ioctl.c
--- linux-2.4.27/fs/smbfs/ioctl.c	2001-10-03 02:03:34.000000000 +0200
+++ linux-2.4.27-smbfs/fs/smbfs/ioctl.c	2004-10-31 00:58:20.000000000 +0200
@@ -32,7 +32,7 @@
 	switch (cmd) {
 	case SMB_IOC_GETMOUNTUID:
 		result = put_user(NEW_TO_OLD_UID(server->mnt->mounted_uid),
-				  (uid16_t *) arg);
+				  (__kernel_old_uid_t *) arg);
 		break;
 	case SMB_IOC_GETMOUNTUID32:
 		result = put_user(server->mnt->mounted_uid, (uid_t *) arg);

--FL5UXtIhxfXey3p5--
