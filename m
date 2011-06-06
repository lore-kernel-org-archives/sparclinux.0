From: Matthias Rosenfelder <rosenfelder.lkml@googlemail.com>
Date: Mon, 06 Jun 2011 23:24:48 +0000
Subject: Re: [PATCH] sparc32,leon: Added __init declaration to leon_flush_needed()
Message-Id: <4DED61C0.8010809@googlemail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <4DCA7CCC.7050404@googlemail.com>
In-Reply-To: <4DCA7CCC.7050404@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 16.05.2011 22:33, David Miller wrote:
> From: Matthias Rosenfelder<rosenfelder.lkml@googlemail.com>
> Date: Wed, 11 May 2011 14:10:52 +0200
>
>> The function leon_flush_needed() is called only during bootup
>> from another __init function. Therefore, we can add
>> __init to leon_flush_needed().
>>
>> Signed-off-by: Matthias Rosenfelder<rosenfelder.lkml@googlemail.com>
>> Acked-by: Daniel Hellstrom<daniel@gaisler.com>
>
> This patch has been corrupted by your email client, making it
> unusable.

I'm sorry. I'm new to sending patches and posting on mailing lists.

Currently, I'm using Thunderbird with standard settings. As I even don't 
know what went wrong when submitting this patch, I would like to know if 
there are any known issues with this software or if there is any 
recommended mail program for working with the kernel mailing lists?!

What program does the usual kernel hacker use?

I also want to apologize for not reacting for such a long time. I'm 
doing this in my spare time only but I didn't have much time lately.

Thank you for your answers.
