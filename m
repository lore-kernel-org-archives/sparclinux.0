From: "David S. Miller" <davem@redhat.com>
Date: Wed, 12 May 2004 19:50:11 +0000
Subject: Re: Another gcc 3.4 fix
Message-Id: <20040512125011.1efd62a3.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20040512052744.GA31207@localhost>
In-Reply-To: <20040512052744.GA31207@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, 12 May 2004 15:45:11 -0400
Mathieu Chouquet-Stringer <mchouque@online.fr> wrote:

> My bad, I had the -fno-unit-at-a-time option on the command line.

Please send the full output gcc-3.4 gives for kernel_unaligned_trap().
There is no way it can delete that whole asm statement that has
the kernel_unaligned_trap_fault definition, the asm is marked
volatile afterall.
