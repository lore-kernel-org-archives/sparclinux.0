From: Ben Collins <bcollins@debian.org>
Date: Tue, 04 May 2004 14:26:55 +0000
Subject: Re: [PATCH] Small cleanup to kernel/setup.c
Message-Id: <20040504142655.GH3647@phunnypharm.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20040504132104.GA23807@artsapartment.org>
In-Reply-To: <20040504132104.GA23807@artsapartment.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> I don't like the original because it keeps doing strcmp() tests more
> times than necessary. That was my motivation in doing changing this bit
> of code.

Only happens once at boot. Can't be that much overhead. Could just add
else's in front of the later if's, and leave the formatting the same.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
