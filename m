From: David Miller <davem@davemloft.net>
Date: Tue, 07 Oct 2014 18:54:20 +0000
Subject: Re: [PATCH] sparc64: use COMMAND_LINE_SIZE for boot string
Message-Id: <20141007.145420.1879773165781982167.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <5432BE03.10405@oracle.com>
In-Reply-To: <5432BE03.10405@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Kjetil Oftedal <oftedal@gmail.com>
Date: Tue, 7 Oct 2014 20:38:57 +0200

> Just a note from the strncpy manpage:
> "If  the  length of src is less than n, strncpy() writes additional null
>  bytes to dest to ensure that a total of n bytes are written."
> 
> So strncpy always writes len bytes, regardless of the presence of a null char.
> (Unless silo strncpy is different ?)

Let's take a look.

SILO's doesn't behave that way, it stops at the first NULL character.

char * strncpy(char *dest, const char *src, size_t count)
{
	char *tmp = dest;

	while (count-- && (*dest++ = *src++) != '\0')
		/* nothing */;

	return tmp;
}
