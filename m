From: "Jean-Fabrice [gmail]" <jeanfabrice@gmail.com>
Date: Tue, 17 Oct 2006 08:39:49 +0000
Subject: qla2xxx issue on >2.6.17 kernel
Message-Id: <da053ca90610170139l693952d4xf09ab500a5e66b12@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

I have the same problem than Jurij Smakov in
http://marc.theaimsgroup.com/?l=linux-sparc&m5985125624301&w=2
My SunFire 280R does not boot 2.6.17 kernel since the qla2xxx driver
doesn't recognize the attached disks. 2.6.16.29 with qlogicfc driver
boots normally.

I read Gustavo answer about CONFIG_SCSI_QLA2XXX_EMBEDDED_FIRMWARE but,
like Jurij, I did not find it the sparc32/64 arch

I'm not using initramfs.

Is there anything I can do to solve this issue ?

Jean-Fabrice
