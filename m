From: chase rayfield <cusbrar1@gmail.com>
Date: Sat, 12 Jul 2014 04:08:33 +0000
Subject: Re: SILO on Qemu Sparc v8 unable to boot stripped kernel
Message-Id: <CACwypyMd8DT+EXj7qOzFn-FAinXTO+BJ_a1R7c+CMjOyb+qh_Q@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <CACwypyMhN9fj34VmgiXEFNmH28up5if3wW_xajYOLy0kR2An5Q@mail.gmail.com>
In-Reply-To: <CACwypyMhN9fj34VmgiXEFNmH28up5if3wW_xajYOLy0kR2An5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I made some progress on this.

The problem is silo is failing to load the compressed image. I copied
an uncompressed kernel onto the ISO and it booted correctly.

I expect silo should be able to load a zImage though...

Chase
