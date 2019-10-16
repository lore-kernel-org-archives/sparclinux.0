From: Meelis Roos <mroos@linux.ee>
Date: Wed, 16 Oct 2019 06:04:31 +0000
Subject: Re: sparc64: hang from BUG: Bad page state, on older CPU & compiler
Message-Id: <d936b304-4808-6a6b-9641-fe8e30345fe2@linux.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <d2a51bfb-84e4-3ce7-ac48-7200b3a8d722@linux.ee>
In-Reply-To: <d2a51bfb-84e4-3ce7-ac48-7200b3a8d722@linux.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> Ok, I'll just remove that HAVE_FAST_GUP - I was expecting it to come
> through David, but I was also really hoping we'd have a guess as to
> why it happens on some hardware and configurations but not others.

It works, thank you - the mutex hang regression in util-linux test suite no longer triggers and we can move forward with sparc64 kernels in debian-ports and also re-check any other regressions found meanwhile. I will recheck my sparc64's and report any surviving regressions if any.

-- 
Meelis Roos <mroos@linux.ee>
