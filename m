From: David Miller <davem@davemloft.net>
Date: Fri, 20 Mar 2015 19:42:47 +0000
Subject: Re: 4.0.0-rc4: panic in free_block
Message-Id: <20150320.154247.1709779134937698942.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <CA+55aFxhNphSMrNvwqj0AQRzuqRdPG11J6DaazKWMb2U+H7wKg@mail.gmail.com>
	<550C5078.8040402@oracle.com>
	<CA+55aFyQWa0PjT-3y-HB9P-UAzThrZme5gj1P6P6hMTTF9cMtA@mail.gmail.com>
In-Reply-To: <CA+55aFyQWa0PjT-3y-HB9P-UAzThrZme5gj1P6P6hMTTF9cMtA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: david.ahern@oracle.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 20 Mar 2015 09:58:25 -0700

> 128 cpu's is still "unusual"

As unusual as the system I do all of my kernel builds on :-)
