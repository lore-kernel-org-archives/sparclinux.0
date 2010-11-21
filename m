From: Daniel Smolik <marvin@mydatex.cz>
Date: Sun, 21 Nov 2010 09:25:53 +0000
Subject: Re: handover boot console problem
Message-Id: <4CE8E5A1.1070303@mydatex.cz>
List-Id: <sparclinux.vger.kernel.org>
References: <4CE81804.3000909@mydatex.cz>
In-Reply-To: <4CE81804.3000909@mydatex.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David Miller napsal(a):
> From: Daniel Smolik <marvin@mydatex.cz>
> Date: Sat, 20 Nov 2010 19:48:36 +0100
> 
>> Hi all,
>> I upgrade my old E250 with RSC console to 2.6.36 an found that there
>> is some broken with handover early console.
>  ...
>> I don't know why console is switched to tty0. With 2.6.26 console work
>> normaly.
> 
> Ten releases is hundreds of megabytes worth of changes, and thus
> makes it difficult to track down the problem.
> 
> Can you try some releases in between to try and bisect this down to
> something more specific?
> 
> Also make sure you do have all the necessary drivers and serial
> console options enabled.
> 
> Thanks.
Yes I can, I mean that problem starts betveen 2.6.26-2.6.32.
Yes I use same config on 2.6.26 and 2.6.32 and 2.6.26 works.

Dan


-- 
Mydatex s r.o.
http://www.mydatex.cz
email: smolik@mydatex.cz
mob: 604200362
tel: 226210085
