From: Meelis Roos <mroos@linux.ee>
Date: Wed, 24 Oct 2018 14:56:13 +0000
Subject: Re: [sparc vdso] compile failure in v4.19-4243-ga978a5b - operation combines symbols in different se
Message-Id: <602ec7e3-0f1a-8f69-237b-0666b3ad861c@linux.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <748cfe51-e74d-f6fc-a806-7689a86399e0@linux.ee>
In-Reply-To: <748cfe51-e74d-f6fc-a806-7689a86399e0@linux.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> This happens on all 4 with 2015-08 32-bit userspace that I tested todays git on:
[...]
> Have not tried on anything with current 64-bit userpace, the machines are not online at the moment.

Tried now, compiles and boots with current debian-ports toolchain.

-- 
Meelis Roos <mroos@linux.ee>
