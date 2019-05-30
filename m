From: Meelis Roos <mroos@linux.ee>
Date: Thu, 30 May 2019 07:43:12 +0000
Subject: Re: [bisected] DEBUG_PAGEALLOC hangs on sparc64
Message-Id: <b33747ea-e92d-8615-d0fe-174d3f62a214@linux.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <86e9d84e-cffa-0bae-f575-7cf6789f5fb8@linux.ee>
In-Reply-To: <86e9d84e-cffa-0bae-f575-7cf6789f5fb8@linux.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> Meelis, could you please try the attached patch to see if it fixes the issue?

It also fixes latest git with DEBUG_PAGEALLOC on V445.

-- 
Meelis Roos <mroos@linux.ee>
