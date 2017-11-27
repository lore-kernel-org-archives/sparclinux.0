From: Meelis Roos <mroos@linux.ee>
Date: Mon, 27 Nov 2017 11:37:07 +0000
Subject: Re: sparc64: git kernel 4.14.0-12995-g0c86a6bd85ff does not boot
Message-Id: <alpine.LRH.2.21.1711271334280.27709@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <CADxRZqxRB=G4+QwYasS0a7GJA-4WJW13NQTm-oEt8QrHgZixSQ@mail.gmail.com>
In-Reply-To: <CADxRZqxRB=G4+QwYasS0a7GJA-4WJW13NQTm-oEt8QrHgZixSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> [    0.176608] Unable to handle kernel NULL pointer dereference in mna handler
> [    0.176614]  at virtual address 0000000000000009
> [    0.176728] current->{active_,}mm->context = 0000000000000000
> [    0.176787] current->{active_,}mm->pgd = fff8004030002000


> [    0.188495] Instruction DUMP:
> [    0.188499]  fa062014
> [    0.188531]  c4260000
> [    0.188558]  c2262004
> [    0.188586] <f8262008>

I am seeing similar problem on V480, with kernel crosscompiled from 
server with gcc (and other up to date userland from Debian sparc64).

Sometimes it happesn after I change a configuration option (like rmeove 
cassini from being built in) and does not go away when I change the 
option back.

-- 
Meelis Roos (mroos@linux.ee)
