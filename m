Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71961C433EF
	for <sparclinux@archiver.kernel.org>; Sun, 20 Feb 2022 21:31:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236628AbiBTVcB (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Sun, 20 Feb 2022 16:32:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbiBTVb7 (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Sun, 20 Feb 2022 16:31:59 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B92071116
        for <sparclinux@vger.kernel.org>; Sun, 20 Feb 2022 13:31:35 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id a19so27062267qvm.4
        for <sparclinux@vger.kernel.org>; Sun, 20 Feb 2022 13:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=leadboat.com; s=google;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=GfihU7K3PdOQV6zhEFFfK6u6utnPI+mCyo7NaP6rKDw=;
        b=ge+AAK6HCIq1OO68URm1qhuzsPLNBKqzPo18c979QQzQ9cHhaEaUE/T+dr2WRUUlAp
         uWQgE+u67hrZxmwgDN9Wtw6E5QjhUUz2ftOcbiyyOoLV7KPw+FxgJ4vnW96Vzm1eCvqS
         4/QJ5ZjVigEKSedbErjmkP1B6pypjAQAjJTlQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=GfihU7K3PdOQV6zhEFFfK6u6utnPI+mCyo7NaP6rKDw=;
        b=YuqgPfD2wGQfUVjMs6ElEU0h0uBXGQrdbnFqsTJqkxGyno6iABih4RlkaE8Tm1yDdR
         uWSdYk2BG8Qt3gqeH4GCybLfMSXaFWq1vWAFXJznNfYRtnbTFZNPlEQANv0pEfn2BJve
         b2cVySfkodCfupu0XV6XbjkG8iDgeoQ+WRTavyk+Z6qiqrrvFKrmajOQYfPciHZ0mCg2
         nk2MBNSn6jUpZNX+nrcyezmoqrotZAVXXlfQ6EG076W7ebYa2fq5FSzyFZHenits0cwg
         +bQF7ZWBglp6+Zo2feeFzSw1RcsmkGcPnhYmyFf6nRu/EA+N4+C2xzN7NLRJZkYGXZND
         IN9g==
X-Gm-Message-State: AOAM530QIXUnaVYzAsVSKiV/32u7eZx/hmHtPjrOkLzitIrGafDArTn2
        AblLRx/1XeFiEbNsmUhxvYlr171CI25pcA==
X-Google-Smtp-Source: ABdhPJwc9crR8Zf1mBQLw+SHRibo/ly5vdpGe3oDmPVIEaxOLREhrwfE3bxmUAFzUw5xcdZRHgvBLA==
X-Received: by 2002:ac8:5b15:0:b0:2dd:d20a:3404 with SMTP id m21-20020ac85b15000000b002ddd20a3404mr9089259qtw.392.1645392694129;
        Sun, 20 Feb 2022 13:31:34 -0800 (PST)
Received: from rfd.leadboat.com ([2600:1702:a20:5750::2e])
        by smtp.gmail.com with ESMTPSA id t18sm29264062qta.90.2022.02.20.13.31.32
        for <sparclinux@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Feb 2022 13:31:33 -0800 (PST)
Date:   Sun, 20 Feb 2022 13:31:31 -0800
From:   Noah Misch <noah@leadboat.com>
To:     sparclinux@vger.kernel.org
Subject: [ext4+sparc64] reads see zeros w/ simultaneous write
Message-ID: <20220220213131.GA3754799@rfd.leadboat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

Hello,

I originally reported this to Debian
(https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1006157), which
advised me to re-report it upstream.  The context is an ext4
filesystem on a sparc64 host.  I've observed this with each of the
three sparc64 Debian kernels that I've tested.  Those kernels were
5.16.0-1-sparc64-smp, 5.15.0-2-sparc64-smp, and 4.9.0-13-sparc64-smp.

   * What exactly did you do (or not do) that was effective (or
     ineffective)?

See the included file for a minimal test program.  It creates two
processes, each of which loops indefinitely.  One opens a file, writes
0x1 to a 256-byte region, and closes the file.  The other process
opens the same file, reads the same region, and prints a message if
any byte is not 0x1.

This thread has more discussion and a more-configurable test program:
https://postgr.es/m/flat/20220116071210.GA735692@rfd.leadboat.com

   * What was the outcome of this action?

The program prints messages, at least ten per second.  The mismatch
always appears at an offset divisible by eight.  Some offsets are more
common than others.  Here's output from 300s of runtime, filtered
through "sort -nk3 | uniq -c":

   1729 mismatch at 8: got 0, want 1
   1878 mismatch at 16: got 0, want 1
   1030 mismatch at 24: got 0, want 1
     41 mismatch at 40: got 0, want 1
    373 mismatch at 48: got 0, want 1
     24 mismatch at 56: got 0, want 1
    349 mismatch at 64: got 0, want 1
  13525 mismatch at 72: got 0, want 1
    401 mismatch at 80: got 0, want 1
    365 mismatch at 88: got 0, want 1
      1 mismatch at 96: got 0, want 1
     32 mismatch at 104: got 0, want 1
     34 mismatch at 112: got 0, want 1
     19 mismatch at 120: got 0, want 1
     34 mismatch at 128: got 0, want 1
    253 mismatch at 136: got 0, want 1
    149 mismatch at 144: got 0, want 1
    138 mismatch at 152: got 0, want 1
      1 mismatch at 160: got 0, want 1
      4 mismatch at 168: got 0, want 1
      7 mismatch at 176: got 0, want 1
      4 mismatch at 184: got 0, want 1
      1 mismatch at 192: got 0, want 1
     83 mismatch at 200: got 0, want 1
     58 mismatch at 208: got 0, want 1
   3301 mismatch at 216: got 0, want 1
      2 mismatch at 232: got 0, want 1
      1 mismatch at 248: got 0, want 1

If I run the program atop an xfs filesystem (still with sparc64), it
prints nothing.  If I run it with x86_64 or powerpc64 (atop ext4), it
prints nothing.

   * What outcome did you expect instead?

I expected the program to print nothing, indicating that the reader
process observes only 0x1 bytes.  That is how x86_64+ext4 behaves.

POSIX is stricter, requiring read() and write() implementations such
that "each call shall either see all of the specified effects of the
other call, or none of them"
(https://pubs.opengroup.org/onlinepubs/9699919799/functions/V2_chap02.html#tag_15_09_07).
ext4 does not conform, which may be pragmatic.  However, with x86_64
and powerpc64, readers see each byte as either its before-write value
or its after-write value.  They don't see a zero in an offset that
will have been nonzero both before and after the ongoing write().


=== sparc64-ext4-zeros.c
/*
 * Stress-test read(), and write() to detect a problem seen with sparc64+ext4.
 * Readers see zeros when they read concurrently with a write, even if the
 * file had no zero at that offset before or after the write.  This program
 * runs indefinitely and will print "mismatch ..." each time that happens.
 */

#include <errno.h>
#include <fcntl.h>
#include <limits.h>
#include <stdio.h>
#include <string.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <unistd.h>

/*
 * Size of block written in a loop and read in another process's loop.  Values
 * lower than about 128 don't reproduce the problem.
 */
#define BLOCK_SIZE 256
/* Offset of that block within file.  Probably any value works. */
#define OFFSET 0
/* Byte to write to every file offset.  Probably any nonzero value works. */
#define FILL_VALUE 1

static ssize_t
my_pread(int fd, void *buf, size_t count, off_t offset)
{
	if (lseek(fd, offset, SEEK_SET) == (off_t) -1)
		perror("lseek");
	return read(fd, buf, count);
}

static ssize_t
my_pwrite(int fd, const void *buf, size_t count, off_t offset)
{
	if (lseek(fd, offset, SEEK_SET) == (off_t) -1)
		perror("lseek");
	return write(fd, buf, count);
}

static int
reopen(void)
{
	int			fd = open("io-rectitude.tmp", O_RDWR);

	if (fd == -1)
		perror("open");
	return fd;
}

static void
writer(int fd)
{
	char		buf[BLOCK_SIZE];

	memset(buf, FILL_VALUE, sizeof(buf));
	for (;;)
	{
		close(fd);
		fd = reopen();
		errno = 0;
		if (my_pwrite(fd, buf, sizeof(buf), OFFSET) != sizeof(buf))
			perror("pwrite");	/* not a defect */
	}
}

static void
reader(int fd)
{
	for (;;)
	{
		unsigned char buf[BLOCK_SIZE];
		close(fd);
		fd = reopen();
		errno = 0;
		if (my_pread(fd, buf, sizeof(buf), OFFSET) != sizeof(buf))
			perror("pread");	/* not a defect */
		else
		{
			int			i;
			for (i = 0; i < sizeof(buf); ++i)
			{
				if (buf[i] != FILL_VALUE)
				{
					fprintf(stderr, "mismatch at %d: got %d, want %d\n",
							i, buf[i], FILL_VALUE);
					break;
				}
			}
		}
	}
}

int
main(int argc, char **argv)
{
	int			fd;
	unsigned char buf[OFFSET + BLOCK_SIZE];
	pid_t		pid;

	fd = open("io-rectitude.tmp", O_RDWR | O_CREAT | O_TRUNC, 0666);
	if (fd == -1)
	{
		perror("open");
		return 1;
	}
	/* initialize file contents */
	memset(buf, FILL_VALUE, sizeof(buf));
	if (write(fd, buf, sizeof(buf)) != sizeof(buf))
	{
		perror("write");
		return 1;
	}

	pid = fork();
	if (pid == -1)
	{
		perror("fork");
		return 1;
	}
	else if (pid == 0)
		writer(fd);
	else
		reader(fd);

	return 0;					/* unreachable */
}
