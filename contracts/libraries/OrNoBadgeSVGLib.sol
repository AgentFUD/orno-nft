// SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

import "@openzeppelin/contracts/utils/Strings.sol";
import "@brechtpd/base64.sol";

library OrNoBadgeSVGLib {
    
    using Strings for uint256;

    string constant svgStart = "<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 900 900'><style>";
    
    // :root styles
    string constant style_10 = ":root {--bg: hsl(0, 0%, 12%);--bg2: hsl(0, 0%, 0%);--moon1: hsl(40, 2%, 25%);--moon2: hsl(191, 13%, 69%); --moon3: hsl(194, 13%, 75%);--moon4: hsl(173, 12%, 87%);--fogback: hsl(275, 40%, 32%);--fogfront: hsl(274, 46%, 25%);--bigstar: hsl(274, 50%, 78%);--txt: hsl(173, 12%, 87%);}";
    string constant style_25 = ":root {--bg: hsl(64, 97%, 16%);--bg2: hsl(64, 97%, 35%);--moon1: hsl(185, 29%, 33%);--moon2: hsl(182, 18%, 65%); --moon3: hsl(182, 23%, 73%);--moon4: hsl(178, 32%, 82%);--fogback: hsl(275, 40%, 32%);--fogfront: hsl(274, 46%, 25%);--bigstar: hsl(274, 50%, 78%);--txt: hsl(0, 0%, 0%);}";
    string constant style_50 = ":root {--bg: hsl(305, 97%, 25%);--bg: hsl(305, 97%, 15%);--moon1: hsl(107, 97%, 15%);--moon2: hsl(107, 97%, 25%); --moon3: hsl(107, 97%, 35%);--moon4: hsl(107, 97%, 55%);--fogback: hsl(275, 40%, 32%);--fogfront: hsl(274, 46%, 25%);--bigstar: hsl(274, 50%, 78%);--txt: hsl(107, 97%, 55%);}";
    string constant style_75 = ":root {--bg: hsl(211, 47%, 30%);--bg2: hsl(211, 47%, 50%);--moon1: hsl(38, 28%, 33%);--moon2: hsl(36, 13%, 69%); --moon3: hsl(37, 13%, 75%);--moon4: hsl(30, 12%, 87%);--fogback: hsl(275, 40%, 32%);--fogfront: hsl(274, 46%, 25%);--bigstar: hsl(274, 50%, 78%);--txt: hsl(0, 0%, 0%);}";
    string constant style_100 = ":root {--bg: hsl(127, 100%, 55%);--bg2: hsl(127, 100%, 35%);--moon1: hsl(270, 39%, 35%);--moon2: hsl(271, 13%, 69%); --moon3: hsl(272, 13%, 75%);--moon4: hsl(30, 12%, 87%);--fogback: hsl(275, 40%, 32%);--fogfront: hsl(209, 100%, 45%);--bigstar: hsl(274, 50%, 78%);--txt: hsl(0, 0%, 0%);}";
    string constant style_150 = ":root {--bg:hsl(291, 82%, 15%);--bg2:hsl(291, 82%, 25%);--moon1: hsl(291, 81%, 35%);--moon2: hsl(291, 81%, 45%); --moon3: hsl(291, 81%, 65%);--moon4: hsl(290, 82%, 85%);--fogback: hsl(0, 0%, 0%);--fogfront: hsl(209, 100%, 45%);--bigstar: hsl(274, 50%, 78%);--txt: hsl(290, 82%, 85%);}";
    string constant style_200 = ":root {--bg:hsl(51, 100%, 50%);--bg2:hsl(51, 100%, 30%);--moon1: hsl(38, 84%, 25%);--moon2: hsl(38, 85%, 35%); --moon3: hsl(38, 85%, 45%);--moon4: hsl(38, 84%, 85%);--fogback: hsl(275, 40%, 32%);--fogfront: hsl(209, 100%, 45%);--bigstar: hsl(274, 50%, 78%);--txt: hsl(0, 0%, 0%);}";
    string constant style_250 = ":root {--bg: hsl(0, 0%, 0%);--bg2: hsl(0, 10%, 10%);--moon1: hsl(71, 72%, 25%);--moon2: hsl(71, 72%, 35%); --moon3: hsl(71, 72%, 45%);--moon4: hsl(71, 72%, 75%);--fogback: hsl(275, 40%, 32%);--fogfront: hsl(274, 46%, 25%);--bigstar: hsl(274, 50%, 78%);--txt: hsl(71, 72%, 75%);}";
    string constant style_350 = ":root {--bg: hsl(195, 100%, 25%);--bg2: hsl(195, 100%, 65%);--moon1: hsl(178, 100%, 23%);--moon2: hsl(182, 50%, 44%); --moon3: hsl(181, 45%, 58%);--moon4: hsl(182, 47%, 79%);--fogback: hsl(275, 40%, 32%);--fogfront: hsl(274, 46%, 25%);--bigstar: hsl(274, 50%, 78%);--txt: hsl(0, 0%, 0%);}";
    string constant style_450 = ":root {--bg: hsl(107, 97%, 20%);--bg2:hsl(0, 0%, 0%);--moon1: hsl(130, 100%, 27%);--moon2: hsl(132, 80%, 40%); --moon3: hsl(120, 58%, 54%);--moon4: hsl(115, 50%, 73%);--fogback: hsl(275, 40%, 32%);--fogfront: hsl(0, 0%, 0%);--bigstar: hsl(274, 50%, 78%);--txt: hsl(115, 50%, 73%);}";
    string constant style_550 = ":root {--bg: hsl(313, 97%, 35%);--bg2: hsl(313, 97%, 65%);--moon1: hsl(27, 100%, 28%);--moon2: hsl(38, 81%, 40%); --moon3: hsl(41, 69%, 46%);--moon4: hsl(39, 64%, 69%);--fogback: hsl(275, 40%, 32%);--fogfront: hsl(274, 46%, 25%);--bigstar: hsl(274, 50%, 78%);--txt: hsl(0, 0%, 0%);}";
    string constant style_750 = ":root {--bg: hsl(270, 800%, 1%);--bg2: hsl(274, 100%, 21%);--moon1: hsl(276, 100%, 30%);--moon2: hsl(281, 52%, 48%); --moon3: hsl(279, 45%, 61%);--moon4: hsl(274, 50%, 78%);--fogback: hsl(275, 40%, 32%);--fogfront: hsl(274, 46%, 25%);--bigstar: hsl(274, 50%, 78%);--txt: hsl(274, 50%, 78%);}";
    string constant style_950 = ":root {--bg: hsl(0, 0%, 0%);--bg2: hsl(0, 30%, 25%);--moon1: hsl(0, 84%, 35%);--moon2: hsl(0, 83%, 45%); --moon3: hsl(0, 83%, 55%);--moon4: hsl(0, 84%, 85%);--fogback: hsl(274, 46%, 25%);--fogfront: hsl(275, 40%, 32%);--bigstar: hsl(274, 50%, 78%);--txt: hsl(0, 84%, 85%);}";
    string constant style_1250 = ":root {--bg: hsl(299, 84%, 15%);--bg2: hsl(299, 84%, 5%);--moon1: hsl(299, 84%, 25%);--moon2: hsl(299, 84%, 35%); --moon3: hsl(299, 83%, 45%);--moon4: hsl(299, 84%, 75%);--fogback: hsl(0, 0%, 0%);--fogfront: hsl(275, 40%, 32%);--bigstar: hsl(274, 50%, 78%);--txt: hsl(299, 84%, 75%);}";
    string constant style_1600 = ":root {--bg: hsl(236, 87%, 05%);--bg2: hsl(236, 87%, 25%);--moon1: hsl(237, 87%, 35%);--moon2: hsl(236, 87%, 45%); --moon3: hsl(237, 87%, 65%);--moon4: hsl(236, 87%, 85%);--fogback: hsl(274, 46%, 25%);--fogfront: hsl(195, 100%, 75%);--bigstar: hsl(274, 50%, 78%);--txt: hsl(236, 87%, 85%);}";
    string constant style_1950 = ":root {--bg: hsl(61, 95%, 35%);--bg2: hsl(61, 95%, 55%);--moon1: hsl(0, 0%, 0%);--moon2: hsl(61, 96%, 35%); --moon3: hsl(61, 96%, 45%);--moon4: hsl(60, 95%, 75%);--fogback: hsl(275, 40%, 32%);--fogfront: hsl(247, 100%, 55%);--bigstar: hsl(274, 50%, 78%);--txt: hsl(0, 0%, 0%);}";
    string constant style_2400 = ":root {--bg: hsl(22, 97%, 15%);--bg2: hsl(22, 97%, 0%);--moon1: hsl(22, 97%, 25%);--moon2: hsl(22, 97%, 35%); --moon3: hsl(22, 97%, 55%);--moon4: hsl(22, 97%, 85%);--fogback: hsl(274, 46%, 25%);--fogfront: hsl(32, 100%, 45%);--bigstar: hsl(274, 50%, 78%);--txt:hsl(22, 97%, 85%);}";
    string constant style_2850 = ":root {--bg: hsl(165, 97%, 5%);--bg2:hsl(165, 97%, 15%);--moon1: hsl(165, 97%, 25%);--moon2: hsl(165, 97%, 35%); --moon3: hsl(164, 97%, 45%);--moon4: hsl(164, 97%, 75%);--fogback: hsl(275, 40%, 32%);--fogfront: hsl(0, 0%, 0%);--bigstar: hsl(274, 50%, 78%);--txt: hsl(164, 97%, 75%);}";
    string constant style_3350 = ":root {--bg:hsl(250, 97%, 22%);--bg2:hsl(250, 97%, 45%);--moon1: hsl(178, 97%, 25%);--moon2: hsl(178, 97%, 35%); --moon3: hsl(177, 97%, 45%);--moon4: hsl(177, 97%, 75%);--fogback: hsl(275, 40%, 32%);--fogfront: hsl(0, 0%, 0%);--bigstar: hsl(274, 50%, 78%);--txt: hsl(177, 97%, 75%);}";
    string constant style_3850 = ":root {--bg:hsl(110, 97%, 45%);--bg2:hsl(110, 97%, 22%);--moon1: hsl(206, 97%, 25%);--moon2: hsl(207, 97%, 35%); --moon3: hsl(206, 97%, 55%);--moon4: hsl(207, 97%, 85%);--fogback: hsl(0, 0%, 0%);--fogfront: hsl(209, 85%, 67%);--bigstar: hsl(274, 50%, 78%);--txt: hsl(207, 97%, 85%);}";
    string constant style_4500 = ":root {--bg:hsl(239, 97%, 25%);--bg2:hsl(239, 77%, 0%);--moon1: hsl(239, 97%, 25%);--moon2: hsl(239, 97%, 35%); --moon3: hsl(239, 97%, 65%);--moon4: hsl(239, 97%, 85%);--fogback: hsl(274, 46%, 15%);--fogfront: hsl(270, 40%, 45%);--bigstar: hsl(274, 50%, 78%);--txt: hsl(239, 97%, 85%);}";
    
    string constant styleEnd = "@keyframes backgroundColorPalette { 0% { background: #ee6055; } 25% { background: #60d394; } 50% { background: #aaf683; } 75% { background: #ffd97d; } 100% { background: #ff9b85; }}@font-face { font-family: 'WF'; src: url(data:application/font-woff2;charset=utf-8;base64,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) format('woff2');}</style>";
    string constant untilLevel = "<g> <linearGradient id='sky' x1='-0.1' y1='0' x2='0.8' y2='1'> <animate attributeName='y2' repeatCount='indefinite' dur='8s' keyTimes='0;0.5;1' values='-0.5;0.5;-0.5' keySplines='0.5 0 0.5 1;0.5 0 0.5 1' calcMode='spline'></animate> <stop stop-color='var(--bg)' offset='0'></stop> <stop stop-color='var(--bg2)' offset='1'></stop></linearGradient><rect x='0' y='0' width='900' height='900' fill='url(#sky)'></rect></g><g fill='var(--fogfront)' stroke='none' opacity='0.6'><path class='cls-3' d='M423.42,842.3c-62.5-28-170.45,4.17-217.58-34.16-30.36-24.68-11.19-61.8,15.56-89.11,18.81-19.22,41.58-38.6,52.88-59.46a48.21,48.21,0,0,0,4.33-34.21c0-.15-.08-.31-.11-.46a74.63,74.63,0,0,0-36.74-48.08c-10-5.5-20-10.93-21.71-11.87-31.84-17.28-68.7-30.91-97.3-50.35C57,469.91,47.32,395.39,100.35,342.3c29.43-29.46,88.22-52.76,136.74-40.62A267.08,267.08,0,0,1,302,230.55a51.3,51.3,0,0,0-9-14c-16.18-17.68-48.38-24.82-80.64-21.83s-64.4,15-92.62,30.37C60.45,257.22,16.66,305.28-1,354.48v97.16c15.66,51.44,45.64,100.18,27,155.28C20.11,624.18,9.7,641-1,657.73V813.54c16.67,13.21,38.39,22.84,63.7,27.05,43.65,7.24,93.05-.24,139.18,1.46s94,17.27,98.56,50.42a38.68,38.68,0,0,1,.27,7.53H463.13C464.32,877.84,451.39,854.83,423.42,842.3Z'/><path class='cls-3' d='M838.21,111.88c-26.67,9.29-45.14,25.79-68,38.65s-56,22.33-82.46,13.68c-29.69-9.72-33.13-37.27-18.57-57s41.54-34.42,63.09-51.39c21-16.56,36.78-35.67,46.77-55.86H571.66C596.74,27.76,637.79,49,636,84.77c-1.57,31.47-36.24,60.77-61.21,90.05a130,130,0,0,0-14.3,20.36,266,266,0,0,1,92.11,61.51c7.29-1.78,14.52-3.59,21.55-5.2,35.82-8.19,83.44-4.68,83.48,21.06,0,11.78-10.85,23.64-22.36,33.74a282.81,282.81,0,0,1-31.85,24.06,266,266,0,0,1,2.83,217c15.46-4.36,30.57-9.08,45.17-14A1385,1385,0,0,0,900,473.49V110.57C882.69,104.33,857.12,105.3,838.21,111.88Z'/></g><g fill='var(--fogback)' stroke='none' opacity='0.5'><path class='cls-4' d='M423.43,843.6c-31.25-12-73.87-8.26-114.56-6.8-40.69,1.65-79.46,1-103-15.4-30.35-21.41-11.18-54,15.56-79.51,26.74-25.33,61.49-54.19,59.92-84.19-1.33-25.48-29.43-44.24-61.27-59.43-31.84-15-68.7-29.25-97.3-51.86C89.88,520.6,71,485.73,67,454c-4-32.13,6.83-61.13,33.35-84.11,15.43-13.4,38.94-25.12,64.82-32.46,18.26-5.09,37.69-8,56.29-6.85A266.42,266.42,0,0,1,293,237.67l-.05-.06c-16.17-17.24-48.38-22.54-80.64-18.54s-64.4,16.37-92.61,30.06C60.45,278.55,16.66,312.78-1,354.48v97.16C14.67,510.24,44.64,567.69,26,616c-5.85,15.21-16.25,28.54-27,41.75V813.54c16.67,15.68,38.39,26.89,63.7,32.3,43.65,9.24,93.05,3.65,139.18,4.95s94,13.23,98.56,42.61a29.75,29.75,0,0,1,.27,6.6H463.13C464.32,877.49,451.39,854.39,423.43,843.6Z'/><path class='cls-4' d='M838.21,102.81c-26.67,5.72-45.14,19.09-68,29.23s-56,17.79-82.46,10.69c-29.69-8-33.12-32.42-18.56-50.23s41.54-30.65,63.08-45c21-14,36.79-30.16,46.77-47.49H571.66C596.75,24.93,637.79,42.16,636,73.7c-1.57,27.71-36.24,55.86-61.21,85.93a125.45,125.45,0,0,0-20.29,33.26,265,265,0,0,1,75.14,42.84c14.87-4.16,30.11-9.15,44.52-12.76C710,213.35,757.6,219,757.64,243.5c0,11.08-10.84,21.47-22.35,30.62a417.05,417.05,0,0,1-45.41,30.74,266.24,266.24,0,0,1,29.67,203.82c10.85-3.18,21.5-6.23,31.89-9C803.18,485.21,852.87,476,900,473.49V110.57C882.69,101.14,857.12,98.78,838.21,102.81Z'/></g><g fill='var(--bigstar)' stroke='none'><path d='M107,736.94l5.4,1.53L107,740a4.43,4.43,0,0,0-3,3l-1.53,5.4-1.53-5.4a4.41,4.41,0,0,0-3-3l-5.4-1.53,5.4-1.53a4.41,4.41,0,0,0,3-3l1.53-5.4,1.53,5.4A4.43,4.43,0,0,0,107,736.94Z'/><path d='M172.64,669.75l3.33,1-3.33.95a2.7,2.7,0,0,0-1.88,1.87l-.94,3.33-.95-3.33a2.67,2.67,0,0,0-1.87-1.87l-3.33-.95,3.33-1a2.67,2.67,0,0,0,1.87-1.87l.95-3.33.94,3.33A2.7,2.7,0,0,0,172.64,669.75Z'/><path d='M816,109.65l3.34.95-3.34.94a2.75,2.75,0,0,0-1.87,1.87l-1,3.34-.94-3.34a2.75,2.75,0,0,0-1.87-1.87L807,110.6l3.34-.95a2.75,2.75,0,0,0,1.87-1.87l.94-3.34,1,3.34A2.75,2.75,0,0,0,816,109.65Z'/><path d='M41.88,368.91l3.34.94-3.34.95A2.71,2.71,0,0,0,40,372.67L39.06,376l-.94-3.33a2.71,2.71,0,0,0-1.87-1.87l-3.34-.95,3.34-.94A2.74,2.74,0,0,0,38.12,367l.94-3.33L40,367A2.74,2.74,0,0,0,41.88,368.91Z'/><path d='M827.71,394.64l5.4,1.53-5.4,1.53a4.41,4.41,0,0,0-3,3l-1.53,5.4-1.53-5.4a4.42,4.42,0,0,0-3-3l-5.41-1.53,5.41-1.53a4.43,4.43,0,0,0,3-3l1.53-5.4,1.53,5.4A4.43,4.43,0,0,0,827.71,394.64Z'/><path d='M739.69,627.31l8.31,2.35L739.69,632a6.76,6.76,0,0,0-4.66,4.67L732.67,645l-2.36-8.31a6.76,6.76,0,0,0-4.66-4.67l-8.31-2.36,8.31-2.35a6.76,6.76,0,0,0,4.66-4.67l2.36-8.31,2.36,8.31A6.76,6.76,0,0,0,739.69,627.31Z'/><path d='M186,198.34l8.31,2.36L186,203.06a6.75,6.75,0,0,0-4.66,4.66L179,216l-2.36-8.31a6.75,6.75,0,0,0-4.66-4.66l-8.31-2.36,8.31-2.36a6.75,6.75,0,0,0,4.66-4.66l2.36-8.31,2.36,8.31A6.75,6.75,0,0,0,186,198.34Z'/></g><g transform='scale(5.2) translate(-641 -70)' stroke='none' ><circle cx='81.05%' cy='17.05%' r='53.1' fill='var(--moon1)'/> <circle cx='80.95%' cy='17%' r='51.2' fill='var(--moon2)' /><circle cx='80.68%' cy='16.9%' r='47' fill='var(--moon3)'/><circle cx='80.5%' cy='16.6%' r='40.4' fill='var(--moon4)'/><circle cx='76.5%' cy='15.8%' r='7' fill='var(--moon4)'/><circle cx='76.5%' cy='15.9%' r='6' fill='var(--moon3)'/> <ellipse cx='81.1%' cy='15.8%' rx='16.8' ry='15.9' fill='var(--moon3)'/> <circle cx='76.1%' cy='17.9%' r='4' fill='var(--moon4)'/><ellipse cx='76.15%' cy='17.89%' rx='3.3' ry='3.5' fill='var(--moon3)'/><circle cx='80.7%' cy='19.6%' r='16.4' fill='var(--moon4)'/> <ellipse cx='80.6%' cy='20.25%' rx='12' ry='10' fill='var(--moon3)'/> <circle cx='78.5%' cy='12.7%' r='3.1' fill='var(--moon4)'/><ellipse cx='83.85%' cy='13.8%' rx='4.2' ry='4.6' fill='var(--moon4)'/><ellipse cx='84.7%' cy='15.7%' rx='7' ry='7.7' fill='var(--moon4)'/><ellipse cx='84.65%' cy='15.68%' rx='7' ry='7.45' fill='var(--moon3)'/><circle cx='83.2%' cy='15.3%' r='3' fill='var(--moon3)'/><ellipse cx='82.1%' cy='18%' rx='4.8' ry='4.4' fill='var(--moon3)'/><circle cx='83.75%' cy='19.5%' r='5.3' fill='var(--moon4)'/><ellipse cx='83.8%' cy='19.5%' rx='4.2' ry='4.7' fill='var(--moon3)'/> </g><text font-family='WF' font-size='80' style='fill: var(--txt)' x='20' y='85' dominant-baseline='left' text-anchor='left' stroke-width='1' stroke='var(--txt)'>orNo LVL #";
    // Flips
    string constant untilText = "</text><text font-family='WF' font-size='180' style='fill: var(--txt)' x='880' y='860' text-anchor='end' stroke-width='1' stroke='var(--txt)'>";
    // Text
    string constant svgEnd = "</text></svg>";

    function getSVG(string memory _text, uint256 _flips) external pure returns (string memory) {
        return _formatTokenURI(_svgToImageURI(_text, _flips));
    }

    function _svgToImageURI(string memory _text, uint256 _flips) internal pure returns (string memory) {        
        
        string memory baseURL = "data:image/svg+xml;base64,";
        string memory style;

        if(_flips == 10) {
            style = style_10;
        } else if(_flips == 25) {
            style = style_25;
        } else if(_flips == 50) {
            style = style_50;
        } else if(_flips == 75) {
            style = style_75;
        } else if(_flips == 100) {
            style = style_100;
        } else if(_flips == 150) {
            style = style_150;
        } else if(_flips == 200) {
            style = style_200;
        } else if(_flips == 250) {
            style = style_250;
        } else if(_flips == 350) {
            style = style_350;
        } else if(_flips == 450) {
            style = style_450;
        } else if(_flips == 550) {
            style = style_550;
        } else if(_flips == 750) {
            style = style_750;
        } else if(_flips == 950) {
            style = style_950;
        } else if(_flips == 1250) {
            style = style_1250;
        } else if(_flips == 1600) {
            style = style_1600;
        } else if(_flips == 1950) {
            style = style_1950;
        } else if(_flips == 2400) {
            style = style_2400;
        } else if(_flips == 2850) {
            style = style_2850;
        } else if(_flips == 3350) {
            style = style_3350;
        } else if(_flips == 3850) {
            style = style_3850;
        } else if(_flips == 4500) {
            style = style_4500;
        }

        string memory svg1 = string(abi.encodePacked(
            svgStart,
            style,
            styleEnd,
            untilLevel
        ));

        string memory svg2 = string(abi.encodePacked(
            _flips.toString(),
            untilText,
            _text,
            svgEnd
        ));

        string memory svgBase64Encoded = Base64.encode(bytes(abi.encodePacked(svg1, svg2)));
        return string(abi.encodePacked(baseURL, svgBase64Encoded));
    }
    
    function _formatTokenURI(string memory _imageURI) internal pure returns (string memory) {
        return string(
            abi.encodePacked(
                "data:application/json;base64,",
                Base64.encode(
                    bytes(
                        abi.encodePacked(
                            '{"name": "OrNo NFT",',
                            '"description": "Coolest thing on the Earth",',
                            '"attributes": "",',
                            '"image": "', _imageURI , '"}'
                        )
                    )
                )
            )
        );       
    }
}