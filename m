From: Bob Breuer <breuerr@mc.net>
Date: Sun, 06 Mar 2011 21:11:20 +0000
Subject: Re: Status update on sparc32 genirq support [Was: sparc32: genirq
Message-Id: <4D73F878.2010308@mc.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20110304214850.GA12197@merkur.ravnborg.org>
In-Reply-To: <20110304214850.GA12197@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Josip Rodin wrote:
> On Sun, Mar 06, 2011 at 10:13:56AM +0100, Marcel van Nies wrote:
>> The hyperSPARC gives the same error without the final genirq patch.
>>
>> On Sun, Mar 6, 2011 at 8:23 AM, Marcel van Nies <morcles@gmail.com> wrote:
>>> The hyperSPARC boots, but fails when starting init. It runs fine on 2.6.17.
> 
> I realize that it may be a difficult proposition, but you could try to
> git bisect it.
> 
> Did you try it on anything after 2.6.17, maybe that narrows it down further?
> 

You shouldn't have to go back that far...  I was last running 2.6.22 on
hyperSPARC successfully.  Ok, maybe that's not so helpful as it looks
like it's been a while since I've built a sparc kernel.  Probably time
for me to also try out a new kernel.

Bob

