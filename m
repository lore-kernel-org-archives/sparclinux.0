From: David Miller <davem@davemloft.net>
Date: Tue, 21 Jan 2020 12:27:25 +0000
Subject: Re: [PATCH] sparc32: fix struct ipc64_perm type definition
Message-Id: <20200121.132725.1938964059289099578.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20200114132633.3694261-1-arnd@arndb.de>
In-Reply-To: <20200114132633.3694261-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: arnd@arndb.de
Cc: sam@ravnborg.org, stable@vger.kernel.org, ldv@altlinux.org, dalias@libc.org, libc-alpha@sourceware.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 14 Jan 2020 14:26:14 +0100

> As discussed in the strace issue tracker, it appears that the sparc32
> sysvipc support has been broken for the past 11 years. It was however
> working in compat mode, which is how it must have escaped most of the
> regular testing.
> 
> The problem is that a cleanup patch inadvertently changed the uid/gid
> fields in struct ipc64_perm from 32-bit types to 16-bit types in uapi
> headers.
> 
> Both glibc and uclibc-ng still use the original types, so they should
> work fine with compat mode, but not natively.  Change the definitions
> to use __kernel_uid32_t and __kernel_gid32_t again.
> 
> Fixes: 83c86984bff2 ("sparc: unify ipcbuf.h")
> Link: https://github.com/strace/strace/issues/116
> Cc: <stable@vger.kernel.org> # v2.6.29
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: "Dmitry V . Levin" <ldv@altlinux.org>
> Cc: Rich Felker <dalias@libc.org>
> Cc: libc-alpha@sourceware.org
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied and queued up for -stable, thanks Arnd.
