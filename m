From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Date: Tue, 09 Jan 2007 13:15:47 +0000
Subject: NFS Oopses on SPARC64?
Message-Id: <200701091315.l09DFl1B006228@laptop13.inf.utfsm.cl>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I've got Oopses with high(ish?) NFS load (compiling stuff on my x86_64 on
my automounted home from SPARC64) with vanilla 2.6.19.1 and 2.6.20-rc4
(didn't do any such madness before, and not in between). Reported as 7795
and 7796 in bugzilla.kernel.org. Aurora Corona on a SPARC Station Ultra 1,
up to date.

Has anybody else seen something like this? This machine has had random NFS
and hang problems, which I didn't have the time to investigate further then.
I attributed them to the (all too common) brownouts here.

I've set up things so I can disassemble/regenerate the .s for the stuff
referenced in the Oops, but I'd rather not (my knowledge of SPARC assembly
is almost non-existent). Any clues/pointers?

Thanks!
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
Casilla 110-V, Valparaiso, Chile               Fax:  +56 32 2797513

