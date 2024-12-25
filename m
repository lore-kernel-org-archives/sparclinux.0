Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3B7433A8;
	Wed, 25 Dec 2024 08:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735116472; cv=none; b=YLJlw6bbmBd30db90tSK9mdwIpxoxEqOW1i2EJ4ENXandHtbbNPMfBa49pLPdAOZCrAi/Eq1bqKao4Q350gHdTzmzTKBu1/rp9JQfZANV/ppZuZ1Msd9smY+V/d7u2z8NsRWlrGJnXERYbZzUgsQtnJqzgLocfxKHAA6aIjp3mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735116472; c=relaxed/simple;
	bh=ljKmAB0VT2J1XoUx9siQ779m5CZ8tdsK068WTcuBiOY=;
	h=Message-ID:Date:MIME-Version:To:CC:References:Subject:From:
	 In-Reply-To:Content-Type; b=Cc3lPmF1Wy3s5dAVoX0v2NRCNSoP6UdaKRH83w8RS09jqF56ZI9d0GvrLzFa2aOquQi2FUze44/7y/t8aE+IssEMLQ5qYVJrEQWiTGH5Rm6PHnYgZxBcJrEbc3ao0IB3mi7QBfTk1aHT6AX4QJbkIdEFEXwy4yoPxxafGP7YKe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4YJ51w54Ssz22jlW;
	Wed, 25 Dec 2024 16:45:40 +0800 (CST)
Received: from kwepemh100007.china.huawei.com (unknown [7.202.181.92])
	by mail.maildlp.com (Postfix) with ESMTPS id 7FB7F18001B;
	Wed, 25 Dec 2024 16:47:40 +0800 (CST)
Received: from [10.67.111.53] (10.67.111.53) by kwepemh100007.china.huawei.com
 (7.202.181.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 25 Dec
 2024 16:47:39 +0800
Message-ID: <e9491088-44b5-4cec-ac61-0d9a31582a8e@huawei.com>
Date: Wed, 25 Dec 2024 16:47:39 +0800
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: <zhangkunbo@huawei.com>
CC: <andreas@gaisler.com>, <bhelgaas@google.com>, <chris.zjh@huawei.com>,
	<davem@davemloft.net>, <liaochang1@huawei.com>,
	<linux-kernel@vger.kernel.org>, <rdunlap@infradead.org>,
	<sparclinux@vger.kernel.org>
References: <20241218074439.3271397-1-zhangkunbo@huawei.com>
Subject: Re: [PATCH -next] sparc: replace zero-length array with
 flexible-array member
From: zhangkunbo <zhangkunbo@huawei.com>
In-Reply-To: <20241218074439.3271397-1-zhangkunbo@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemh100007.china.huawei.com (7.202.181.92)

ping gently.

