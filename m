From: Meelis Roos <mroos@linux.ee>
Date: Thu, 30 May 2019 05:24:06 +0000
Subject: Re: [bisected] DEBUG_PAGEALLOC hangs on sparc64
Message-Id: <18bc6015-0d57-ec80-d6af-ccd91ace7dd1@linux.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <86e9d84e-cffa-0bae-f575-7cf6789f5fb8@linux.ee>
In-Reply-To: <86e9d84e-cffa-0bae-f575-7cf6789f5fb8@linux.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> Meelis, could you please try the attached patch to see if it fixes the issue?

Works on top of both the offending commit and current git, on V440 - thank you!

Will try on V445 too, hopefully today.

-- 
Meelis Roos
