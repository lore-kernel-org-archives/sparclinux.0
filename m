From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Thu, 24 Sep 2020 13:50:14 +0000
Subject: [PATCH] kbuild: explicitly specify the build id style
Message-Id: <CA+icZUX+AX4GAG0z2PAnvJSEmKozYLa7oHjxGkjv2_9Rcs0J7A@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20200922232140.1994390-1-morbo@google.com>
In-Reply-To: <20200922232140.1994390-1-morbo@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bill Wendling <morbo@google.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, Andy Lutomirski <luto@kernel.org>, Michal Marek <michal.lkml@markovi.net>, Catalin Marinas <catalin.marinas@arm.com>, "David S . Miller" <davem@davemloft.net>, Will Deacon <will@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, netdev@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Nathan Chancellor <natechancellor@gmail.com>, Sami Tolvanen <samitolvanen@google.com>

[ Please CC me I am not subscribed to all MLs ]
[ CC Sami ]

Hi Bill,

I have tested your patch on top of Sami's latest clang-cfi Git branch.

Feel free to add...

Tested-by: Sedat Dilek <sedat.dilek@gmail.com> # LLVM toolchain
version 11.0.0-rc3 on x86-64

Thanks for the patch.

Regards,
- Sedat -
