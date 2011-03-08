From: Marcel van Nies <morcles@gmail.com>
Date: Tue, 08 Mar 2011 21:27:39 +0000
Subject: Re: Status update on sparc32 genirq support
Message-Id: <AANLkTintoo5Nth=oneUxWi7Xsf2gJwr6SUrJSPK5QG_J@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20110307.230120.226776255.davem@davemloft.net>
In-Reply-To: <20110307.230120.226776255.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

/sbin/fsck.ext3 is there, it's used to check / in runlevel 1, i.e. every boot.

I can happily boot anything 2.6.32.27 or earlier.

Marcel

On Tue, Mar 8, 2011 at 10:19 PM, David Miller <davem@davemloft.net> wrote:
> From: Marcel van Nies <morcles@gmail.com>
> Date: Tue, 8 Mar 2011 22:13:05 +0100
>
>> So, is this an ESP or EXT2 bug at all ?
>
> The error message is that the program "fsck.ext3" cannot be found.
> Does that binary exist in the correct location so that fsck can
> find it?
>
