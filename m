Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFAB8627B;
	Wed,  8 May 2024 17:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715189946; cv=none; b=M0ZQVIorvkPrctm7nGBqQJSsBQA5eYIobXImEvM5osUTrGmEcwUnzYAjp+rsQCUmpcKYZlmufeExZPTN8ElmBGRrfB7zQxi27/gXOtML1UdHR8xDrXcwY0BxCj82f1ntoEsv/pkMhodGXqzHhPfAkFW6WoQS67cDFsMG7o3bYcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715189946; c=relaxed/simple;
	bh=LO7i7sQO4MqQMc1B4tt+VB5Hu/Yg7PANDh0Eux/X8ZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HsdzpKF5EmOLZ1jq8+dWupBn86N8ygrZ+N6pskQtoF82ETPCEnmRy9nhClYEaYB1KevgvyMt595LbphNAPI8RWnjYBLuUg/2XE4U9hVtQyTU2kFD4mT3AsBk5BLtxe2n5IgxCpfA3q3BOkHTVUIP9c/iZYAGFmVhjqFHCt6LGAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=eeYzy00E; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="eeYzy00E"
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4VZMnl3XYbz67wy;
	Wed,  8 May 2024 19:38:51 +0200 (CEST)
Received: from [192.168.0.25] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4VZMnl1q52z67ss;
	Wed,  8 May 2024 19:38:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=unoeuro; t=1715189931;
	bh=H+x6ud2ZgGykL5+mc3itKgKKEUCNkLgRmPvK9fe1WOE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=eeYzy00EgK8caGzPQ6pGYNXsxAEG2or02TWqnLQIZtCMt1nV24Ie/TWd+lBtMRQB5
	 p8CT3t4faoKlrisZeoe/sQ0hPdSlroYZMkvCWYQMYsvPP1UQNra9eLfXd4hIQWZ+6Y
	 BS8ReYigEd254pFn9TkVNCdsIROGHIz2v3xLKJDo=
Message-ID: <716be276-077e-4200-9581-eeb1c1899d20@gaisler.com>
Date: Wed, 8 May 2024 19:38:50 +0200
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/5] Remove onstack cpumask var for sparc
To: Dawei Li <dawei.li@shingroup.cn>, davem@davemloft.net
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, sam@ravnborg.org
References: <20240424025548.3765250-1-dawei.li@shingroup.cn>
 <2E1672E07EE140B4+Zjok8JvIOXBNZnVJ@centos8>
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <2E1672E07EE140B4+Zjok8JvIOXBNZnVJ@centos8>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-05-07 14:56, Dawei Li wrote:
> Hi Andreas,
> 
> On Wed, Apr 24, 2024 at 10:55:43AM +0800, Dawei Li wrote:
>> Hi,
>>
>> This is v4 of previous series on removal of on-stack cpumask var for
>> sparc arch.
>>
>> Change since v3:
>>
>> - Rebased against for-next of Andreas.
>>
>> - Add Reviewed-by from Sam.
>>
>> - Remove PATCH(sparc/init: Remove on-stack cpumask var).
>>
>> v1:
>> https://lore.kernel.org/all/20240418104949.3606645-1-dawei.li@shingroup.cn/
>>
>> v2:
>> https://lore.kernel.org/all/20240420051547.3681642-1-dawei.li@shingroup.cn/
>>
>> v3:
>> https://lore.kernel.org/all/20240423083043.3735921-1-dawei.li@shingroup.cn/
>>
>> Dawei Li (5):
>>   sparc/srmmu: Remove on-stack cpumask var
>>   sparc/irq: Remove on-stack cpumask var
>>   sparc/of: Remove on-stack cpumask var
>>   sparc/pci_msi: Remove on-stack cpumask var
>>   sparc/leon: Remove on-stack cpumask var
>>
>>  arch/sparc/kernel/irq_64.c       | 10 +++-----
>>  arch/sparc/kernel/leon_kernel.c  |  7 +++---
>>  arch/sparc/kernel/of_device_64.c |  5 +---
>>  arch/sparc/kernel/pci_msi.c      |  5 +---
>>  arch/sparc/mm/srmmu.c            | 40 ++++++++++----------------------
>>  5 files changed, 20 insertions(+), 47 deletions(-)
> 
> Any chance of getting this series queued up for v6.10?
Yes. Picking the series up to my for-next.

Reviewed-by: Andreas Larsson <andreas@gaisler.com>

Thanks,
Andreas

