From: David Miller <davem@davemloft.net>
Date: Fri, 27 Jul 2007 02:09:22 +0000
Subject: Fw: /proc/bus/pci IOCTL breakage
Message-Id: <20070726.190922.122833826.davem@davemloft.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="--Next_Part(Thu_Jul_26_19_09_22_2007_013)--"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

----Next_Part(Thu_Jul_26_19_09_22_2007_013)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit


This is the cause of the 2.6.23-rc1 ioctl problems...

----Next_Part(Thu_Jul_26_19_09_22_2007_013)--
Content-Type: Message/Rfc822
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Return-Path: <davem@vger.kernel.org>
X-Original-To: davem@sunset.davemloft.net
Delivered-To: davem@sunset.davemloft.net
Received: from vger.kernel.org (vger.kernel.org [209.132.176.167])
	by sunset.davemloft.net (Postfix) with ESMTP id 07EF129010C
	for <davem@sunset.davemloft.net>; Thu, 26 Jul 2007 19:08:23 -0700 (PDT)
Received: (from localhost user: 'davem' uid#2109 fake: STDIN
	(davem@vger.kernel.org)) by vger.kernel.org id S934298AbXG0CIL
	(ORCPT <rfc822;davem@sunset.davemloft.net>);
	Thu, 26 Jul 2007 22:08:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934000AbXG0CIK (ORCPT <rfc822;davem@davemloft.net>);
	Thu, 26 Jul 2007 22:08:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759927AbXG0CHx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jul 2007 22:07:53 -0400
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:47482
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1759319AbXG0CHw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jul 2007 22:07:52 -0400
Received: from localhost (localhost [127.0.0.1])
	by sunset.davemloft.net (Postfix) with ESMTP id 8109D29010A;
	Thu, 26 Jul 2007 19:07:51 -0700 (PDT)
Date: Thu, 26 Jul 2007 19:07:51 -0700 (PDT)
Message-Id: <20070726.190751.66179795.davem@davemloft.net>
To: linux-kernel@vger.kernel.org
CC: adobriyan@sw.ru
Subject: /proc/bus/pci IOCTL breakage
From: David Miller <davem@davemloft.net>
X-Mailer: Mew version 5.1.52 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: "David S. Miller" <davem@vger.kernel.org>
Fake-Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org


This change:

commit 786d7e1612f0b0adb6046f19b906609e4fe8b1ba
Author: Alexey Dobriyan <adobriyan@sw.ru>
Date:   Sun Jul 15 23:39:00 2007 -0700

    Fix rmmod/read/write races in /proc entries

Broke ioctl() on /proc/bus/pci/* files for COMPAT platforms.

proc_fops->ioctl() is defined for these PCI device files, and the
COMPAT ioctl is handled via fs/compat_ioctl.c's entries, which makes
it just call the ->ioctl() handler directly.

proc_fops->compat_ioctl is NULL for these files, it isn't needed.

This used to work because we used to jump right to the de->proc_fops,
but now we have these wrappers and proc_reg_compat_ioctl is what
gets called and since proc_fops->compat_ioctl is NULL we return
ENOTTY instead of calling proc_fops->ioctl().

Two ways to fix:

1) Make the PROC wrapper call ->unlocked_ioctl() or ->ioctl()
   as a fallback of ->compat_ioctl is NULL.

2) Make proc_bus_pci_operations provide a .compat_ioctl method,
   but then we'll need to audit the entire tree for cases like
   this and make the same fix.

Because it's easier to validate that all cases are covered,
I think #1 is the preferred fix.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----Next_Part(Thu_Jul_26_19_09_22_2007_013)----
