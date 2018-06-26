From: Chaitra Basappa <chaitra.basappa@broadcom.com>
Date: Tue, 26 Jun 2018 12:17:53 +0000
Subject: RE: mpt3sas regression...
Message-Id: <fc8425808a51356656b6519f20d547e3@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20180624.134639.2035609272357314002.davem@davemloft.net>
In-Reply-To: <20180624.134639.2035609272357314002.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi David,
 Sorry for the inconvenience caused. Yes,  "scsi: mpt3sas: Bug fix for big
endian systems." patch was posted to fix sparse warnings.
I missed the testing. Currently we are testing on sparc64 system and soon
I will be reposting the patch based on the findings.

Thanks,
 Chaitra


-----Original Message-----
From: David Miller [mailto:davem@davemloft.net]
Sent: Sunday, June 24, 2018 10:17 AM
To: linux-scsi@vger.kernel.org
Cc: chaitra.basappa@broadcom.com; sparclinux@vger.kernel.org
Subject: mpt3sas regression...


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
