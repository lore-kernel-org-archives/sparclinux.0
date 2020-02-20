From: Nathan Chancellor <natechancellor@gmail.com>
Date: Thu, 20 Feb 2020 17:42:43 +0000
Subject: Re: [PATCH v2 2/2] compiler: Remove CONFIG_OPTIMIZE_INLINING entirely
Message-Id: <20200220174243.GB40621@ubuntu-m2-xlarge-x86>
List-Id: <sparclinux.vger.kernel.org>
References: <20200220110807.32534-1-masahiroy@kernel.org>
 <20200220110807.32534-2-masahiroy@kernel.org>
In-Reply-To: <20200220110807.32534-2-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org, clang-built-linux@googlegroups.com, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, sparclinux@vger.kernel.org, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org

On Thu, Feb 20, 2020 at 08:08:07PM +0900, Masahiro Yamada wrote:
> Commit ac7c3e4ff401 ("compiler: enable CONFIG_OPTIMIZE_INLINING
> forcibly") made this always-on option. We released v5.4 and v5.5
> including that commit.
> 
> Remove the CONFIG option and clean up the code now.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> Reviewed-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
