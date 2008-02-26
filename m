From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Date: Tue, 26 Feb 2008 16:32:56 +0000
Subject: Patches to update silo
Message-Id: <1204043579-5056-1-git-send-email-vonbrand@inf.utfsm.cl>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

The following series of 3 patches folds most changes in Aurora into the
current silo git repository.

The one change I did not take over is to echo a suggestion to run silo in
the %post section of the specfile, AFAIU Fedora guidelines explicitly forbid
any output. The installation should be automatic (yes, I was bitten by not
seeing the message amongs the copious yum output on updating), but from the
%changelog I see that running it automatically had been removed. This still
needs fixing.

 second/fs/ext2.c |    5 ++---
 second/main.c    |    2 --
 silo.spec        |   37 ++++++++++++++++++++++++-------------
 3 files changed, 26 insertions(+), 18 deletions(-)
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
Casilla 110-V, Valparaiso, Chile               Fax:  +56 32 2797513
