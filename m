From: Ben Collins <ben.collins@ubuntu.com>
Date: Tue, 26 Feb 2008 17:03:14 +0000
Subject: Re: Patches to update silo
Message-Id: <1204045394.7510.77.camel@cunning>
List-Id: <sparclinux.vger.kernel.org>
References: <1204043579-5056-1-git-send-email-vonbrand@inf.utfsm.cl>
In-Reply-To: <1204043579-5056-1-git-send-email-vonbrand@inf.utfsm.cl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


On Tue, 2008-02-26 at 13:32 -0300, Horst H. von Brand wrote:
> The following series of 3 patches folds most changes in Aurora into the
> current silo git repository.
> 
> The one change I did not take over is to echo a suggestion to run silo in
> the %post section of the specfile, AFAIU Fedora guidelines explicitly forbid
> any output. The installation should be automatic (yes, I was bitten by not
> seeing the message amongs the copious yum output on updating), but from the
> %changelog I see that running it automatically had been removed. This still
> needs fixing.

Thanks Horst! I'll merge these when I get back home.

>  second/fs/ext2.c |    5 ++---
>  second/main.c    |    2 --
>  silo.spec        |   37 ++++++++++++++++++++++++-------------
>  3 files changed, 26 insertions(+), 18 deletions(-)
-- 
Ubuntu   : http://www.ubuntu.com/
Linux1394: http://wiki.linux1394.org/
SwissDisk: http://www.swissdisk.com/
> 

