From: Bob <bo-liu@hotmail.com>
Date: Wed, 10 Dec 2008 08:00:03 +0000
Subject: RE: Why need to load %%l0 register during switch_to macro
Message-Id: <COL115-W766342BEE2A4B8F3552E29FFB0@phx.gbl>
List-Id: <sparclinux.vger.kernel.org>
References: <COL115-W7714A68DEBC5468C2E0AF59FFB0@phx.gbl>
In-Reply-To: <COL115-W7714A68DEBC5468C2E0AF59FFB0@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


I have read it , but aslo couldn't understand. 
 
I didn't found where the trap return path use the l0/l1 register, in which file?
 
I am just a newbie. SOrry for troubling you!
 
Thanks!

---
Best regards

Bo Liu





> Date: Tue, 9 Dec 2008 19:06:22 -0800
> To: bo-liu@hotmail.com
> CC: sparclinux@vger.kernel.org
> Subject: Re: Why need to load %%l0 register during switch_to macro
> From: davem@davemloft.net
> 
> From: Bob 
> Date: Wed, 10 Dec 2008 10:37:36 +0800
> 
>> I have another question about switch_to macro.
>> 
>> Why need to load %%l0 register during switch_to macro?
>> 
>> "ldd [%%sp+0x00], %%l0" 
>> 
>> I think load %%i6 is enough.
> 
> Read the comment about the switch_to() macro, it explains
> this. I don't see how you could miss it.
> 
> The trap return path for newly forked child tasks depend upon these
> specific registers being setup a certain way.
_________________________________________________________________
Invite your mail contacts to join your friends list with Windows Live Spaces. It's easy!
http://spaces.live.com/spacesapi.aspx?wx_action=create&wx_url=/friends.aspx&mkt=en-us
