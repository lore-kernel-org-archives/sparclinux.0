From: "Jurij Smakov" <jurij@wooyd.org>
Date: Wed, 18 Oct 2006 19:38:38 +0000
Subject: Re: Problems booting 2.6.18 on SunBlade 100/150
Message-Id: <53701.128.200.30.71.1161200318.squirrel@webmail.wooyd.org>
List-Id: <sparclinux.vger.kernel.org>
References: <200401070729.56891.pkarlsen@mandriva.com>
In-Reply-To: <200401070729.56891.pkarlsen@mandriva.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> From: Jim Watson <jim@amarooas.com.au>
> Date: Wed, 18 Oct 2006 21:50:24 +1000
>
>> David, thanks - I tried the patch on 2.6.18 but it still hangs up for
>> me. This is not conclusive however as I could not get my build of
>> 2.6.16 to run either. The output from the regs remains as before.
>
> It should remain the same.
>
> Are you sure you're enabling ATYFB video support in your kernel?
> That's a common error when folks build their own kernels.

Jim, if you have a recent Debian's linux-image package installed, you can
just use the config Debian uses. It is installed in
/boot/config-2.6.18-1-sparc64 or something like that. Just copy it into
your build directory as .config and run 'make oldconfig'. That will
probably take a bit longer to build, but will have all the required
pieces.

I've tried to build the patched Debian packages overnight, but the build
failed for unrelated reasons. I'll try again tonight.

Jurij Smakov                                           jurij@wooyd.org
Key: http://www.wooyd.org/pgpkey/                      KeyID: C99E03CC



