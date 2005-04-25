From: Jurij Smakov <jurij@wooyd.org>
Date: Mon, 25 Apr 2005 03:07:13 +0000
Subject: Re: Sunsab serial console problems - partially solved
Message-Id: <Pine.LNX.4.61.0504242304410.4507@bobcat>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.61.0503092118230.2897@bobcat>
In-Reply-To: <Pine.LNX.4.61.0503092118230.2897@bobcat>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi Dave,

On Sun, 24 Apr 2005, David S. Miller wrote:
> On Wed, 9 Mar 2005 21:39:39 -0500 (EST)
> Jurij Smakov <jurij@wooyd.org> wrote:
>
>> For the last few days I have been trying to fix the problems with serial
>> console on the machines with sunsab serial controller (I can reproduce
>> them myself on my Ultra 5, another person reported similar issues on an
>> Ultra 10). When booting a 2.6 kernel using serial console, some junk gets
>> occasionally printed on it (see [0] and [1] for thescreenshots). Machine
>> also eventually hangs. After poking around a bit and comparing sunsab.c
>> driver with the working sunzilog.c driver, I came up with the patch
>> against 2.6.11 (attached), which takes care of the hang, but does not
>> eliminate garbage on the console. I am pretty sure by now that this is a
>> result of improper handling of the mode changes, as I see numerous calls
>> to sunsab_set_mctrl() and sunsab_set_termios() right before and/or during
>> the appearance of spurious symbols. As it is a little bit over my head, I
>> hope someone more knowledgeable can give me a clue on how to debug this
>> further.
>
> Jurij, is the machine hang fixed by the patch I wrote in the thread
> with Eric Brower about the missing uart_update_timeout() calls in the
> sunsab.c driver?
>
> I imagine the garbage output still needs to be addressed and I'll try
> to check that out.

Yes, the key there was the call to uart_update_timeout(), which I've 
inserted into my patch completely by accident :-). Your patch has an 
equivalent effect, but occasional garbage is still displayed. I am pretty 
sure that it shows up in the moments when serial console settings are 
changed.

Thanks for looking into it,

Jurij Smakov                                        jurij@wooyd.org
Key: http://www.wooyd.org/pgpkey/                   KeyID: C99E03CC
