From: "David S. Miller" <davem@davemloft.net>
Date: Thu, 11 Nov 2004 19:04:14 +0000
Subject: Re: ioct32 bit compatibilty questions
Message-Id: <20041111110414.2cffeb6a.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20041111110024.GA8836@spring.luon.net>
In-Reply-To: <20041111110024.GA8836@spring.luon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, 11 Nov 2004 12:00:24 +0100
sjoerd@spring.luon.net (Sjoerd Simons) wrote:

>   After some debugging it seems that some alsa ioctl have a pointer to a
>   userspace pointer in their argument struct. When doing a copy_to_user in the
>   native ioctl to that address (thus directly to the 32bit userspace program
>   while get_fs() = KERNEL_DS), the machine just hangs.  Is this something 
>   that can't be done on sparc64 ?

That's right, this action is illegal and will hang the machine.
Unfortunately, on x86_64 this happens to work and that appears
to be where most of the ioctl32 compat stuff gets tested and
developed.

If get_fs() = KERNEL_DS all "user" pointers are expected to be in
kernel space and thus access to real user addresses will fail.
