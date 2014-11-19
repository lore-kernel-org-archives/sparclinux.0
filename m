From: Thomas Gleixner <tglx@linutronix.de>
Date: Wed, 19 Nov 2014 12:40:58 +0000
Subject: Re: [PATCHv8 1/4] syscalls,x86: implement execveat() system call
Message-Id: <alpine.DEB.2.11.1411191249560.3909@nanos>
List-Id: <sparclinux.vger.kernel.org>
References: <1415982183-20525-1-git-send-email-drysdale@google.com> <1415982183-20525-2-git-send-email-drysdale@google.com>
In-Reply-To: <1415982183-20525-2-git-send-email-drysdale@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Drysdale <drysdale@google.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Andy Lutomirski <luto@amacapital.net>, Alexander Viro <viro@zeniv.linux.org.uk>, Meredydd Luff <meredydd@senatehouse.org>, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>, Oleg Nesterov <oleg@redhat.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>, Rich Felker <dalias@aerifal.cx>, Christoph Hellwig <hch@infradead.org>, x86@kernel.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, sparclinux@vger.kernel.org

On Fri, 14 Nov 2014, David Drysdale wrote:
> Only x86-64, i386 and x32 ABIs are supported in this patch.

Can you please split this into the core/fs changes and the actual x86
hookup?
 
Thanks,

	tglx
