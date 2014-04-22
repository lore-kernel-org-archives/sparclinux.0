From: David Miller <davem@davemloft.net>
Date: Tue, 22 Apr 2014 21:50:03 +0000
Subject: Re: [PATCH] sparc: implement is_32bit_task
Message-Id: <20140422.175003.2300632264161817071.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1398202804-30164-1-git-send-email-eparis@redhat.com>
In-Reply-To: <1398202804-30164-1-git-send-email-eparis@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Eric Paris <eparis@redhat.com>
Date: Tue, 22 Apr 2014 17:40:04 -0400

> We are currently embedding the same check from thread_info.h into
> syscall.h thanks to the way syscall_get_arch() was implemented in the
> audit tree.  Instead create a new function, is_32bit_task() which is
> similar to that found on the powerpc arch.  This simplifies the
> syscall.h code and makes the build/Kconfig requirements much easier
> to understand.
> 
> Signed-off-by: Eric Paris <eparis@redhat.com

Acked-by: David S. Miller <davem@davemloft.net>
