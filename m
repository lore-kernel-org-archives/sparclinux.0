From: Meelis Roos <mroos@linux.ee>
Date: Wed, 11 Oct 2006 14:54:46 +0000
Subject: Re: serial console broken on Ultra 5
Message-Id: <Pine.SOC.4.61.0610111753200.14544@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.61.0607311538510.25364@math.ut.ee>
In-Reply-To: <Pine.SOC.4.61.0607311538510.25364@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

>>>> Linux version 2.6.18-rc3 (mroos@mandariin) (gcc version 4.1.2 20060715 (prerelease) (Debian 4.1.1-9)) #137 Mon Jul 31 15:09:20o6
>>>
>>> Retry with gcc-4.0.x please.
>>
>> Same hang exactly.
>
> Thanks for testing, I'll look into it.

I have narrowed it down to a specific config option - 
CONFIG_DEBUG_SPINLOCK. When I enable it, the hang occurs, and when I 
disable it, everything works fine. Currently at 2.6.19-rc1 + git as of 
yesterday.

-- 
Meelis Roos (mroos@linux.ee)
