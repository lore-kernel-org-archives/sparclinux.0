From: David Miller <davem@davemloft.net>
Date: Sun, 24 Jun 2018 04:46:39 +0000
Subject: mpt3sas regression...
Message-Id: <20180624.134639.2035609272357314002.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Commit:

==========
commit cf6bf9710cabba1fe94a4349f4eb8db623c77ebc
Author: Chaitra P B <chaitra.basappa@broadcom.com>
Date:   Tue Apr 24 05:28:30 2018 -0400

    scsi: mpt3sas: Bug fix for big endian systems.
==========

actually breaks big-endian.  This driver has been working perfectly
fine for more a decade or so on my sparc64 test systems up until this
point.

If you are just responding to sparse warnings, please do not do that.
What big-endian system did you test this change on?

Meanwhile, I'd like to ask that this change be reverted.

Thank you.
