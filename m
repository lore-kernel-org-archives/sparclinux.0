From: "David S. Miller" <davem@redhat.com>
Date: Wed, 10 Mar 2004 22:01:15 +0000
Subject: Re: strange exit paths for do_sparc64_fault?
Message-Id: <20040310140115.29769231.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <87n06oiml6.fsf@uga.edu>
In-Reply-To: <87n06oiml6.fsf@uga.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, 10 Mar 2004 13:27:49 -0500
Ed L Cashin <ecashin@uga.edu> wrote:

> Is there a situation where the mmap_sem is taken on entering
> do_sparc64_fault but released outside of do_sparc64_fault?

Yes, if the process dies due to a fatal fault and thus invokes
do_exit() to kill the process, it will never return back into
do_sparc64_fault() if that occurs.
