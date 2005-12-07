From: "J.O. Aho" <trizt@iname.com>
Date: Wed, 07 Dec 2005 11:05:43 +0000
Subject: Re: Sparc: Kernel 2.6.13 to 2.6.15-rc2 bug when running X11
Message-Id: <Pine.LNX.4.64.0512071203460.8861@localhost.localdomain>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.0512060257160.27930@lai.local.lan>
 <20051205.181732.34234732.davem@davemloft.net> <Pine.LNX.4.64.0512061658190.14952@lai.local.lan>
 <20051206.152316.82233251.davem@davemloft.net>
In-Reply-To: <20051206.152316.82233251.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-kernel maillist <linux-kernel@vger.kernel.org>, sparclinux@vger.kernel.org

On Tue, 6 Dec 2005, David S. Miller wrote:

> From: "J.O. Aho" <trizt@iname.com>
> Date: Tue, 6 Dec 2005 17:10:07 +0100 (CET)
>
>> On Mon, 5 Dec 2005, David S. Miller wrote:
>>
>>> 2) You didn't give what the failure mode is for kernels such
>>>   as 2.6.14.2, which should work, and certainly don't print out
>>>   that bug message
>>
>> It's the same as for 2.6.13 and 2.6.15rc, did build a 2.6.14.3 as had
>> removed the 14.2 when I started to use 15rc.
>
> You're still not answering my question, what is this failure
> mode?  Xorg doesn't start?  The kernel crashes when Xorg starts?
> Xorg starts but you get a blank screen?  You did not mention
> this critical information anywhere.  Mentioning a list of other
> kernels that "it's the same" for doesn't describe the failure
> mode. :)

Sorry, thought the log from Xorg was quite selfexplaining

Xorg jumps to VT7, you see a console cursor, "_", at the top left corner 
and thats it. It's impossible to change back to VT1 (or any other), the 
only thing that works is to press [stop]-[a] so that you get back to the
OBP from where I can reset the machine (resetting by the reset button 
don't work). It's still possible to ssh to the machine, more and dmesg is 
possible, but running ps causes the machine to completly lock up, change 
init mode don't give any affects att all and trying to turn off or kill X 
results in the same as ps.

When running in plain console (without trying to run X) everything works 
fine (just telling that so I won't get people to ask if ps segfaults in 
other cases or claims that my init is broke and so on).


-- 
       //Aho

   ------------------------------------------------------------------------
    E-Mail: trizt@iname.com            URL: http://www.kotiaho.net/~trizt/
       ICQ: 13696780
    System: Linux System                        (PPC7447/1000 AMD K7A/2000)
   ------------------------------------------------------------------------
              EU forbids you to send spam without my permission
   ------------------------------------------------------------------------
