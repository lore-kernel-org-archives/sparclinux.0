From: crn@netunix.com
Date: Mon, 07 May 2012 10:26:46 +0000
Subject: Re: sparc sun4c support - time to drop it?
Message-Id: <alpine.LNX.2.00.1205071115390.19978@post.netunix.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20120505162104.GA14563@merkur.ravnborg.org>
In-Reply-To: <20120505162104.GA14563@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org



On Sun, 6 May 2012, Kaj-Michael Lang wrote:

> On Sun, 2012-05-06 at 20:29 +1000, Julian Calaby wrote:
>> You know, with a few simple hand tools, a replacement battery, and
>> some knowledge of OpenFirmware, you can fix them.
>
> Yes, I know, I've done it for an ELC once. But I'm lazy :)

I am in favour of dropping Sun4c (and possibly Sun4d but thats a different 
story) for all new kernels.
All of the possible hardware combinations for Sun4c have been covered 
since 2.2.x and nothing new will happen. Modern kernels need more 
memory and these machines are all limited to 64Mb or less.

Those who want to keep thse antiques alive should just use the older 
kernels. BSD is faster on Sun4c anyway due to task swapping issues.

