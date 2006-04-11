From: Jim Gifford <maillist@jg555.com>
Date: Tue, 11 Apr 2006 06:42:31 +0000
Subject: Re: More on the Sun Disk Label Issue
Message-Id: <443B4FD7.1010904@jg555.com>
List-Id: <sparclinux.vger.kernel.org>
References: <443AE0BA.8070706@jg555.com>
In-Reply-To: <443AE0BA.8070706@jg555.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David S. Miller wrote:
> From: Jim Gifford <maillist@jg555.com>
> Date: Mon, 10 Apr 2006 23:12:07 -0700
>
>   
>> The bottom line somehow the writing of the header is not being done 
>> correctly. If it's fdisk or something related to the kernel, that's what 
>> I'm trying to determine.
>>     
>
> So let's start from the very beginning.
>
> If you have an existing system that works, and you run a gcc-4.1
> compiled kernel on it, does that work?
>   
It works, but if the paritition is was created by a fdisk compiled with 
GCC 4.1, it will give the checksum error during bootup. It just hangs, 
the kernel works fine, but if you are using udev, this error prevents 
the kernel from creating devices in /dev.

With everything I've discovered, and not my team, tonight. The problem 
is actually a util-linux issue and not a kernel issue. The issue is that 
util-linux doesn't generate a proper sun disk label, when it's built 
with GCC 4.1.
