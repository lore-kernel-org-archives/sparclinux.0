From: David Miller <davem@davemloft.net>
Date: Fri, 27 Sep 2013 20:21:59 +0000
Subject: buggy strlcpy conversion...
Message-Id: <20130927.162159.111927974139022741.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Commit 117a0c5fc9c2d06045bd217385b2b39ea426b5a6 ("sparc: kernel: using
strlcpy() instead of strcpy()") added a bug to ldom_reboot in
arch/sparc/kernel/ds.c

-		strcpy(full_boot_str + strlen("boot "), boot_command);
+		strlcpy(full_boot_str + strlen("boot "), boot_command,
+			sizeof(full_boot_str + strlen("boot ")));

That last sizeof() expression evaluates to sizeof(size_t) which is
not what you intended.

Also even the corrected:

	sizeof(full_boot_str) + strlen("boot ")

is not right as the destination buffer length is just plain
"sizeof(full_boot_str)" and that's what the final argument
should be.

I'm checking in a fix based upon the above after a few test boots.
