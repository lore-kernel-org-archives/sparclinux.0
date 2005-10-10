From: Meelis Roos <mroos@linux.ee>
Date: Mon, 10 Oct 2005 20:22:59 +0000
Subject: Re: Yesterdays git does not boot on U5
Message-Id: <Pine.SOC.4.61.0510102322100.10419@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.61.0510101057330.28936@math.ut.ee>
In-Reply-To: <Pine.SOC.4.61.0510101057330.28936@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> I bet the timer interrupt in the OBP is still firing and that's
> why we crash.  We must not, in any way, call into the firmware
> between the setup_tba() call and the completion of
> inherit_prom_mappings_post() because the firmware page tables
> are not active and we'll fault on any access to the firmware's
> address space.
>
> Does this fix it?

Tested it to be sure it's something else. No, this does not fix it as 
you probably already guessed by the next mail.

-- 
Meelis Roos (mroos@linux.ee)
