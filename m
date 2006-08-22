From: Meelis Roos <mroos@linux.ee>
Date: Tue, 22 Aug 2006 04:34:05 +0000
Subject: Re: compile error in 2.6.18-rc4
Message-Id: <Pine.SOC.4.61.0608220733300.4950@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.61.0608130728160.4598@math.ut.ee>
In-Reply-To: <Pine.SOC.4.61.0608130728160.4598@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

>> It's the "%uhi", it should be "%%uhi" since we want a real "%" there
>> and not an argument expansion.
>
> Meelis, give this patch a spin.

Acked-by: Meelis Roos <mroos@linux.ee>

-- 
Meelis Roos (mroos@linux.ee)
